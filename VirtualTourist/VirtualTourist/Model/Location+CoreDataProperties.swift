//
//  Location+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-05-05.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var firstTimeOpened: Bool
    @NSManaged public var id: String?
    @NSManaged public var latitude: Float
    @NSManaged public var longitude: Float
    @NSManaged public var numberOfPages: Int32
    @NSManaged public var page: Int32
    @NSManaged public var image: NSSet?

}

// MARK: Generated accessors for image
extension Location {

    @objc(addImageObject:)
    @NSManaged public func addToImage(_ value: Image)

    @objc(removeImageObject:)
    @NSManaged public func removeFromImage(_ value: Image)

    @objc(addImage:)
    @NSManaged public func addToImage(_ values: NSSet)

    @objc(removeImage:)
    @NSManaged public func removeFromImage(_ values: NSSet)

}
