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
	
	private var clPoint = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
	
	public func getLocation() -> CLLocationCoordinate2D { return clPoint }
	
	/// MARK: - Handle touch events
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		guard let location = touches.first?.location(in: self) else { return }
		
		print(annotations.count)
		clPoint = convert(location, toCoordinateFrom: self)
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		guard let location = touches.first?.location(in: self) else { return }
		clPoint = convert(location, toCoordinateFrom: self)
		createAnnotation()
		
	}
	
	public func createAnnotation() {
	
		let annotation = MKPointAnnotation()
		annotation.coordinate = clPoint
		addAnnotation(annotation)
		print("Added pin no. \(annotations.count)")
	}
}
