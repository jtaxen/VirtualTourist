//
//  Image+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-05-03.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var id: String?
    @NSManaged public var imageData: NSData?
    @NSManaged public var owner: String?
    @NSManaged public var title: String?
    @NSManaged public var url_m: String?
    @NSManaged public var location: Location?

}
