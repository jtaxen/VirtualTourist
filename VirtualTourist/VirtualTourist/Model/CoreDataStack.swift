//
//  CoreDataStack.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-18.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import CoreData

class CoreDataStack {
	
	private let model: NSManagedObjectModel
	internal let coordinator: NSPersistentStoreCoordinator
	private let modelURL: URL
	internal let dbURL: URL
	internal let persistingContext: NSManagedObjectContext
	internal let backgroundContext: NSManagedObjectContext
	let context: NSManagedObjectContext
	
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
		
		context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
		context.parent = persistingContext
		
		backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
		backgroundContext.parent = context
		
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
	
	typealias Batch = (_ workerContext: NSManagedObjectContext) -> ()
	
	func performBackgroundBatchOperation(_ batch: @escaping Batch) {
		backgroundContext.perform() {
			batch(self.backgroundContext)

			do {
				try self.backgroundContext.save()
			} catch {
				fatalError("Error while saving main context: \(error)")
			}
		}
	}
}

extension CoreDataStack {
	
	func save() {
		
		context.performAndWait {
			if self.context.hasChanges {
				do {
					try self.context.save()
				} catch {
					fatalError("Error while saving main context \(error)")
				}
				
				self.persistingContext.perform() {
					do {
						try self.persistingContext.save()
					} catch {
						fatalError("Error while saving persisting context: \(error)")
					}
				}
			}
		}
	}
	
	func autosave(_ delayInSeconds: Int) {
		
		if delayInSeconds > 0 {
			do {
				try self.context.save()
				print("Autosaving")
			} catch {
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
