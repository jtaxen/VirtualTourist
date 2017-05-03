//
//  Image+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-18.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image");
    }

    @NSManaged public var id: String?
    @NSManaged public var owner: String?
    @NSManaged public var title: String?
    @NSManaged public var url_m: String?
    @NSManaged public var location: Location?
	@NSManaged public var imageData: Data?

}
