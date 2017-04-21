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
		
		var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView
		
		guard pinView == nil else {
			pinView!.annotation = annotation
			return pinView
		}
		
		pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
		pinView!.canShowCallout = false
		pinView!.pinTintColor = UIColor.red
		pinView!.animatesDrop = true
		return pinView
	}
	
	func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let controller = storyboard.instantiateViewController(withIdentifier: "albumNavigation") as! AlbumNavigationController
		
		controller.annotationCoordinate = map.getLocation()
		
		present(controller, animated: true, completion: nil)
		
	}
}
