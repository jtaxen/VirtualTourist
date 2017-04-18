//
//  Location+CoreDataClass.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-18.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation
import CoreData

@objc(Location)
public class Location: NSManagedObject {
	
	convenience init?(modelName: String = "New location", context: NSManagedObjectContext) {
		
		if let ent = NSEntityDescription.entity(forEntityName: "Location", in: context) {
			self.init(entity: ent, insertInto: context)
		} else {
			fatalError("Unable to find entity name.")
		}
	}

}
