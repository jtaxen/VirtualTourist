//
//  CoreDataTest.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-19.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import XCTest
import CoreData
@testable import VirtualTourist

class CoreDataTest: XCTestCase {
	
	static var stack: CoreDataStack?
	static var location: Location!
	static var testImageParameters: [String: AnyObject]!
	static var testImage: FlickrImage!
	static var sortDescriptor: [NSSortDescriptor]!
	static var testLocationId: String!
	static var testLocationImage: NSSet?

    override class func setUp() {
        super.setUp()
		
		stack = CoreDataStack(modelName: "ImageModel")
		
		testImageParameters = [
			FlickrClient.ImageProperties.ID: "33293451864" as AnyObject,
			FlickrClient.ImageProperties.Owner: "51644972@N07" as AnyObject,
			FlickrClient.ImageProperties.Title: "Good title" as AnyObject,
			FlickrClient.ImageProperties.Url: "https://farm3.staticflickr.com/2923/33293451864_94fdb11cab.jpg" as AnyObject
		]
		
		testLocationId = "abc123"
		
		sortDescriptor = [
			NSSortDescriptor(key: FlickrClient.ImageProperties.ID, ascending: true)
		]
		
		testImage = FlickrImage(testImageParameters)
    }
    
    override class func tearDown() {
		do {
			try stack?.dropAllData()
		} catch {
			print("Error droping all objects in DB.")
		}
        super.tearDown()
    }
	
	func testSavingImage() {
		
		guard CoreDataTest.stack != nil else {
			XCTFail("Stack is nil")
			return
		}
		let image = Image(CoreDataTest.testImage, context: CoreDataTest.stack!.context)
		XCTAssertNotNil(image)
		
			CoreDataTest.stack?.save()
		
		let fc = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
		fc.sortDescriptors = CoreDataTest.sortDescriptor
		let frc = NSFetchedResultsController<NSFetchRequestResult>(fetchRequest: fc, managedObjectContext: CoreDataTest.stack!.context, sectionNameKeyPath: nil, cacheName: nil)
		
		do {
			try frc.performFetch()
		} catch let error as NSError {
			XCTFail("Error: \(error)")
		}
		
		let objects = frc.fetchedObjects
		XCTAssertNotNil(objects)
		guard objects != nil else {
			XCTFail("Objects are nil")
			return
		}
		
		let object = frc.object(at: IndexPath(row: 0, section: 0)) as! Image
		
		XCTAssertEqual(object.title, CoreDataTest.testImageParameters[FlickrClient.ImageProperties.Title] as? String)
	}
	
	func testFetchingImage() {
		
		guard CoreDataTest.stack != nil else {
			XCTFail("Stack is nil")
			return
		}
	
		let fc = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
		fc.sortDescriptors = CoreDataTest.sortDescriptor
		let frc = NSFetchedResultsController<NSFetchRequestResult>(fetchRequest: fc, managedObjectContext: CoreDataTest.stack!.context, sectionNameKeyPath: nil, cacheName: nil)
		
		do {
			try frc.performFetch()
		} catch let error as NSError {
			XCTFail("Error: \(error)")
		}
		
		guard frc.fetchedObjects != nil else {
			XCTFail("Fetch failed. Object list is nil.")
			return
		}
		
		XCTAssertNotEqual(frc.fetchedObjects!.count, 0)
		guard (frc.fetchedObjects?.count)! > 0 else {
			XCTFail("Array count is zero")
			return
		}
		
		let image = frc.object(at: IndexPath(row: 0, section: 0)) as! Image
		
		XCTAssertEqual(image.id, CoreDataTest.testImageParameters[FlickrClient.ImageProperties.ID] as? String)
	}
	
	func testSavingLocation() {
		
		guard CoreDataTest.stack != nil else {
			XCTFail("Stack is nil")
			return
		}
		
		let imageSet = NSSet(object: CoreDataTest.testImage)
		
		let location = Location(id: CoreDataTest.testLocationId, image: imageSet, context: CoreDataTest.stack!.context)
		
		XCTAssertNotNil(location)
		
		CoreDataTest.stack?.save()
		
		let fc = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
		fc.sortDescriptors = CoreDataTest.sortDescriptor
		let frc = NSFetchedResultsController<NSFetchRequestResult>(fetchRequest: fc, managedObjectContext: CoreDataTest.stack!.context, sectionNameKeyPath: nil, cacheName: nil)
		
		do {
			try frc.performFetch()
		} catch let error as NSError {
			XCTFail("Error: \(error)")
		}
		
		let objects = frc.fetchedObjects
		XCTAssertNotNil(objects)
		guard objects != nil else {
			XCTFail("Objects are nil")
			return
		}
		
		let object = frc.object(at: IndexPath(row: 0, section: 0)) as! Location
		
		XCTAssertEqual(object.id, CoreDataTest.testLocationId)
	}
	
	func testFetchingLocation() {
	
		guard CoreDataTest.stack != nil else {
			XCTFail("Stack is nil")
			return
		}
		
		let fc = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
		fc.sortDescriptors = CoreDataTest.sortDescriptor
		let frc = NSFetchedResultsController<NSFetchRequestResult>(fetchRequest: fc, managedObjectContext: CoreDataTest.stack!.context, sectionNameKeyPath: nil, cacheName: nil)
		
		do {
			try frc.performFetch()
		} catch let error as NSError {
			XCTFail("Error: \(error)")
		}
		
		guard frc.fetchedObjects != nil else {
			XCTFail("Fetch failed. Object list is nil.")
			return
		}
		
		XCTAssertNotEqual(frc.fetchedObjects!.count, 0)
		guard (frc.fetchedObjects?.count)! > 0 else {
			XCTFail("Array count is zero")
			return
		}
		
		let location = frc.object(at: IndexPath(row: 0, section: 0)) as! Location
		
		XCTAssertEqual(location.id, CoreDataTest.testLocationId)
	}
}
