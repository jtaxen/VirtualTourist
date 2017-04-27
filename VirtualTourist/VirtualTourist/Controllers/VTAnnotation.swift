//
//  VTAnnotation.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-27.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation
import MapKit

class VTAnnotation: MKPointAnnotation {
	
	public private(set) var location: Location!
	public private(set) var images: [Image] = []
	
	convenience init(location: Location) {
		self.init()
		self.location = location
	}
	
	public func addImages(_ images: [Image]) {
		self.images.append(contentsOf: images)
	}
	
	public func addImage(_ image: Image)  {
		self.images.append(image)
	}

}
