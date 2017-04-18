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
	
	convenience init?(modelName: String = "New image", context: NSManagedObjectContext) {
	
		if let ent = NSEntityDescription.entity(forEntityName: "Image", in: context) {
			self.init(entity: ent, insertInto: context)
		} else {
			fatalError("Unable to find entity name.")
		}
	}
}
