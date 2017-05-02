//
//  Location+CoreDataClass.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-18.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

@objc(Location)
public class Location: NSManagedObject {
	
	// MARK: - Initializer independent of the FlickrImage struct.
	convenience init?(id: String?, image: NSSet?, coordinate: CLLocationCoordinate2D, context: NSManagedObjectContext) {
		
		guard let ent = NSEntityDescription.entity(forEntityName: "Location", in: context) else {
			fatalError("Unable to find entity name.")
		}
		
		self.init(entity: ent, insertInto: context)
		
		self.id = id 
		self.image = image
		self.latitude = Float(coordinate.latitude)
		self.longitude = Float(coordinate.longitude)
		self.firstTimeOpened = true
	}
}
