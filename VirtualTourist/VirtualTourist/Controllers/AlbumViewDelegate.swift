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
	
	/// Return the number of items in the collection view
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 13
	}
	
	/// Returns a cell
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCell
		// Everyother cell is blue, and everyother brown, so that they are visible when empty
		cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.blue : UIColor.brown
		
		// TODO: - Is it supposed to look like this?!
		cell.spinner = createSpinner(superview: cell)
		cell.contentView.addSubview(cell.spinner)
		cell.spinner.startAnimating()
		
		return cell
		
	}
	
	/// Specifies the size of each cell
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: CGFloat((collectionView.frame.size.width - 50) / 3), height: CGFloat((collectionView.frame.size.width - 50) / 3))
	}
}

// MARK: - Delegate for fetched results controller
extension AlbumViewController: NSFetchedResultsControllerDelegate {
	
}

// MARK: - Delegate for map view
extension AlbumViewController: MKMapViewDelegate {
	
	/// Creates a pin annotation view for each annotation.
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
