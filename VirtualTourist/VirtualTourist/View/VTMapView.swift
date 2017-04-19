//
//  VTMapView.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-18.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class VTMapView: MKMapView {
	
	

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let touch = touches.first!
		let location = touch.location(in: self)
		let annotation = MKPointAnnotation()
		annotation.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(location.x), CLLocationDegrees(location.y))
		self.addAnnotation(annotation)
	}
	
	
}
