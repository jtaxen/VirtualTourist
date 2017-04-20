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
	
	/// MARK: - Initializer independent of the FlickrImage struct.
	convenience init?(id: String?, image: NSSet?, context: NSManagedObjectContext) {
		
		guard let ent = NSEntityDescription.entity(forEntityName: "Location", in: context) else {
			fatalError("Unable to find entity name.")
		}
		
		self.init(entity: ent, insertInto: context)
		
		self.id = id 
		self.image = image 
	}
}
