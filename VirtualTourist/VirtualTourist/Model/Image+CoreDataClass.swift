//
//  Image+CoreDataClass.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-18.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation
import CoreData

@objc(Image)
public class Image: NSManagedObject {
	
	convenience init?(_ image: FlickrImage, context: NSManagedObjectContext) {
		
		guard let ent = NSEntityDescription.entity(forEntityName: "Image", in: context) else {
			fatalError("Unable to find entity name.")
		}
		self.init(entity: ent, insertInto: context)
		self.id = image.id
		self.owner = image.owner
		self.title = image.title
		self.url_m = image.url_m
		self.imageData = nil
	}
	
	// MARK: - Initializer independent of the FlickrImage struct.
	convenience init?(_ parameters: [String: AnyObject], context: NSManagedObjectContext) {
		
		guard let ent = NSEntityDescription.entity(forEntityName: "Image", in: context) else {
			fatalError("Unable to find entity name.")
		}
		
		self.init(entity: ent, insertInto: context)
		
		self.location = parameters["location"] as! Location?
		self.id = parameters["id"] as! String?
		self.owner = parameters["owner"] as! String?
		self.title = parameters["title"] as! String?
		self.url_m = parameters["url_m"] as! String?
		self.imageData = parameters["image_data"] as! Data?
		
	}
}
