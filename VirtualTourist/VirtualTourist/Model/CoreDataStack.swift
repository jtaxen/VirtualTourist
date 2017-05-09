//
//  CoreDataStack.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-18.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import UIKit
import CoreData


class CoreDataStack {
	
	private let model: NSManagedObjectModel
	internal let coordinator: NSPersistentStoreCoordinator
	private let modelURL: URL
	internal let dbURL: URL
	let persistingContext: NSManagedObjectContext
	
	static let sharedInstance = CoreDataStack(modelName: "ImageModel")
	let appDelegate = UIApplication.shared.delegate as! AppDelegate
	
	init?(modelName: String) {
		
		guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
			print("Unable to find \(modelName) in the main bundle.")
			return nil
		}
		
		self.modelURL = modelURL
		
		guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
			print("Unable to create model from \(modelURL).")
			return nil
		}
		
		self.model = model
		
		coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
		
		persistingContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
		persistingContext.persistentStoreCoordinator = coordinator
		
		let fm = FileManager.default
		
		guard let docUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
			print("Unable to reach document folder.")
			return nil
		}
		
		self.dbURL = docUrl.appendingPathComponent("model.sqlite")
		
		let options = [NSInferMappingModelAutomaticallyOption: true, NSMigratePersistentStoresAutomaticallyOption: true]
		
		do {
			try addStoreCoordinator(NSSQLiteStoreType, configuration: nil, storeURL: dbURL, options: options as [NSObject: AnyObject]?)
		} catch {
			debugPrint(error)
			print("Unable to add store at \(dbURL)")
		}
	}
	
	func addStoreCoordinator(_ storeType: String, configuration: String?, storeURL: URL, options: [NSObject: AnyObject]?) throws {
		try coordinator.addPersistentStore(ofType: storeType, configurationName: configuration, at: storeURL, options: options)
	}
}

internal extension CoreDataStack {
	
	func dropAllData() throws {
		try coordinator.destroyPersistentStore(at: dbURL, ofType: NSSQLiteStoreType, options: nil)
		try addStoreCoordinator(NSSQLiteStoreType, configuration: nil, storeURL: dbURL, options: nil)
	}
}

extension CoreDataStack {
	
	func save() {
		
		persistingContext.performAndWait {
			if self.persistingContext.hasChanges {
				do {
					try self.persistingContext.save()
					print("Saved context")
				} catch {
					debugPrint(error)
					fatalError("Error while saving main context \(error)")
				}
			}
		}
	}
	
	func autosave(_ delayInSeconds: Int) {
		
		if delayInSeconds > 0 {
			do {
				try self.persistingContext.save()
				print("Autosaving")
			} catch {
				debugPrint(error)
				print("Error while autosaving.")
			}
			
			let delayInNanoseconds = UInt64(delayInSeconds) * NSEC_PER_SEC
			let time = DispatchTime.now() + Double( Int64( delayInNanoseconds)) / Double(NSEC_PER_SEC)
			
			DispatchQueue.main.asyncAfter(deadline: time) {
				self.autosave(delayInSeconds)
			}
		}
	}
}

extension CoreDataStack {
	
	public func fetchLocations() -> [Location]? {
		
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
		let controller = NSFetchedResultsController<NSFetchRequestResult>(fetchRequest: fetchRequest, managedObjectContext: persistingContext, sectionNameKeyPath: nil, cacheName: nil)
		
		do {
			try controller.performFetch()
		} catch {
			debugPrint(error)
			return nil
		}
		
		print("Fetched \((controller.fetchedObjects?.count ?? 0 )) locations.")
		return controller.fetchedObjects as? [Location]
	}
	
	public func fetchImages(fromLocation location: Location) -> [Image]? {
		
		let locationPredicate = NSPredicate(format: "id == %@", argumentArray: [location.id!])
		
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
		fetchRequest.predicate = locationPredicate
		let controller = NSFetchedResultsController<NSFetchRequestResult>(fetchRequest: fetchRequest, managedObjectContext: persistingContext, sectionNameKeyPath: nil, cacheName: nil)
		
		do {
			try controller.performFetch()
		} catch {
			debugPrint(error)
			return nil
		}
		
		return controller.fetchedObjects as? [Image]
	}
}
