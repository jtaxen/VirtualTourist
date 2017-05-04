//
//  AlbumViewUI.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-28.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation
import UIKit
import MapKit

internal extension AlbumViewController {

	func createSpinner(superview view: UIView) -> UIActivityIndicatorView {
		
		let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
		spinner.hidesWhenStopped = true
		
		let x = view.frame.width.subtracting(spinner.frame.width).multiplied(by: CGFloat(0.5))
		let y = view.frame.height.subtracting(spinner.frame.height).multiplied(by: CGFloat(0.5))
		let newFrame = CGRect(x: x, y: y, width: spinner.frame.width, height: spinner.frame.height)
		spinner.frame = newFrame
		
		return spinner
	}
	
	/// Set up the map view
	func prepareMap() {
		
		map.isUserInteractionEnabled = false
		map.centerCoordinate = centerPoint
		let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
		let region = MKCoordinateRegion(center: centerPoint, span: span)
		map.setRegion(region, animated: true)
		
		let annotation = MKPointAnnotation()
		annotation.coordinate = centerPoint
		map.addAnnotation(annotation)
		
	}
	
	/// Set up the collection view
	func prepareCollectionView() {
		
		collection.dataSource = self
		collection.delegate = self
		collection.register(AlbumCell.self, forCellWithReuseIdentifier: "albumCell")
	}
	
	func deleteButton() -> UIButton {
		
		let frame = newCollectionButton.frame
		let origin = CGPoint(x: frame.origin.x, y: frame.origin.y.adding(frame.size.height))
		let size = frame.size
		
		let newFrame = CGRect(origin: origin, size: size)
		
		let button = UIButton(frame: newFrame)
		button.addTarget(self, action: #selector(deleteChosenImages), for: .touchUpInside)
		
		button.setTitle("Remove images", for: .normal)
		button.backgroundColor = UIColor.white
		button.setTitleColor(UIColor.blue, for: .normal)
		button.titleLabel?.font = UIFont(name: "Futura", size: CGFloat(17))
		
		return button
	}
	
	func presentDeleteButton() {
		
		let button = deleteButton()
		let frame = newCollectionButton.frame
		
		view.addSubview(button)
		button.layoutIfNeeded()
		UIView.animate(withDuration: 0.2) {
			button.frame = frame
			button.layoutIfNeeded()
		}
	}
	
	func removeDeleteButton() {
		
		let button = view.subviews.last!
		let origin = CGPoint(x: button.frame.origin.x, y: button.frame.origin.y.adding((button.frame.height)))
		let size = button.frame.size
		
		button.layoutIfNeeded()
		UIView.animate(withDuration: 0.2) {
			button.frame = CGRect(origin: origin, size: size)
			button.layoutIfNeeded()
		}
		
		for i in collection.indexPathsForSelectedItems! {
			collection.deselectItem(at: i, animated: false)
		}
	}
}
