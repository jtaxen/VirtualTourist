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
	private let coordinator: NSPersistentStoreCoordinator
	private let modelURL: URL
	private let dbURL: URL
	let context: NSManagedObjectContext
	
	init?(modelName: String) {
		
		guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
			print("Error: can not find model \(modelName) in main bundle.")
			return nil
		}
		
		self.modelURL = modelURL
		
		guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
			print("Unable to create a model from \(modelURL)")
			return nil
		}
		
		self.model = model
		
		coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
		
		context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
		context.persistentStoreCoordinator = coordinator
		
		let fm = FileManager.default
		
		guard let docURL = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
			print("Unable to reach the documents folder")
			return nil
		}
		
		let dbURL = docURL.appendingPathComponent("model.sqlite")
		
		do {
			try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: dbURL, options: nil)
		} catch {
			print("Unable to add store at \(dbURL)")
		}
		
		self.dbURL = dbURL
		
	}
}
