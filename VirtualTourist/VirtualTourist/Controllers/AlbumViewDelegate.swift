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
extension AlbumViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard images != nil else { return 0 }
		
		return images!.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCell
		cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.blue : UIColor.brown
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: CGFloat((collectionView.frame.size.width - 100) / 3), height: CGFloat((collectionView.frame.size.width - 100 ) / 3))
	}
	
	
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
