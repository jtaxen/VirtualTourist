//
//  MapViewDelegate.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-18.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import MapKit

/// MARK: - MKMapView delegate
extension MapViewController {
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		
		let reuseID = "pin"
		
		var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? Pin
		
//		pinView?.coordinate = annotation.coordinate
		
		guard pinView == nil else {
			pinView!.annotation = annotation
			return pinView
		}
		
		pinView = Pin(annotation: annotation, reuseIdentifier: reuseID, coordinate: annotation.coordinate)
		pinView!.canShowCallout = false
		pinView!.pinTintColor = UIColor.red
		pinView!.animatesDrop = true
		return pinView
	}
	
	func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
		
		let pin = view as! Pin
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let controller = storyboard.instantiateViewController(withIdentifier: "albumView") as! AlbumViewController
		
		controller.setCenter(pin.coordinate)
		navigationController?.pushViewController(controller, animated: true)
	}
}
