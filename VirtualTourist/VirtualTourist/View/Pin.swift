//
//  Pin.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-21.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import UIKit
import MapKit

class Pin: MKPinAnnotationView {
	
	private(set) var coordinate: CLLocationCoordinate2D!
	public var hasStoredImages: Bool!
	
	init(annotation: VTAnnotation?, reuseIdentifier: String?, coordinate: CLLocationCoordinate2D) {
		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
		self.coordinate = coordinate
		hasStoredImages = false
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}
