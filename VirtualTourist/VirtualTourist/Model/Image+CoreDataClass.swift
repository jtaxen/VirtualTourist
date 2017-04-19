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
		
		if let ent = NSEntityDescription.entity(forEntityName: "Image", in: context) {
			self.init(entity: ent, insertInto: context)
			self.id = image.id
			self.owner = image.owner
			self.title = image.title
			self.url_m = image.url_m
		} else {
			fatalError("Unable to find entity name.")
		}
	}
}
