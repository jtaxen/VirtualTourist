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
	
	/// The point where the user touches the map, in map coordinates.
	public private(set) var clPoint = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
	
	// MARK: - Handle touch events
	/**
	When the map view is touched, the point is converted from the view's coordinate system to the map's system (WGS 84) and stored in clPoint.
	*/
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		guard let location = touches.first?.location(in: self) else { return }
		clPoint = convert(location, toCoordinateFrom: self)
	}
	
	/**
	Creates a new annotation and adds it to the map.
	*/
	public func createAnnotation() -> MKPointAnnotation {
	
		let annotation = MKPointAnnotation()
		annotation.coordinate = clPoint
		addAnnotation(annotation)
		return annotation
	}
}
