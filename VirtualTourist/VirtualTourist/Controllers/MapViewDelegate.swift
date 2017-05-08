//
//  MapViewDelegate.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-18.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import MapKit

// MARK: - MKMapView delegate
extension MapViewController {
	
	/* 
	Adds an annotation view for each annotation
	**/
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		
		let reuseID = "pin"
		
		var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? Pin
		
		guard pinView == nil else {
			pinView!.annotation = annotation
			return pinView
		}
		
		
//		let vtAnnotation = VTAnnotation(location: location)
		
		pinView = Pin(annotation: (annotation as! VTAnnotation), reuseIdentifier: reuseID, coordinate: annotation.coordinate)
		pinView!.canShowCallout = false
		pinView!.pinTintColor = UIColor.red
		pinView!.animatesDrop = true
		return pinView
	}
	
	/*
	In regular mode, selecting a pin pushes the album view. In deletion mode, it removes the annotation.
	**/
	func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
		
		if !delitingIsEnabled {
			let pin = view as! Pin
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let controller = storyboard.instantiateViewController(withIdentifier: "albumView") as! AlbumViewController
			
			controller.currentAnnotation = pin.annotation as! VTAnnotation!
			controller.modelImages = CoreDataStack.sharedInstance!.fetchImages(fromLocation: (pin.annotation as! VTAnnotation).location)!
			controller.numberOfCells = controller.modelImages.count
			
			navigationController?.pushViewController(controller, animated: true)
		}
		
		if delitingIsEnabled {
			guard let annotation = view.annotation as? VTAnnotation else { return }
			CoreDataStack.sharedInstance?.context.delete(annotation.location)
			print("removed a pin")
			mapView.removeAnnotation(annotation)
		}
	}
}
