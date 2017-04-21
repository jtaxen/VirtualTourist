//
//  AlbumViewDelegate.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-21.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MapKit

// MARK: - Delegate for the collection view
extension AlbumViewController: UICollectionViewDelegate {

	 
	
}

// MARK: - Delegate for fetched results controller
extension AlbumViewController: NSFetchedResultsControllerDelegate {

}

// MARK: - Delegate for map view
extension AlbumViewController: MKMapViewDelegate {
	
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
}
