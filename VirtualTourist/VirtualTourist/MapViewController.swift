//
//  MapViewController.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-11.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
	
	/// Map view
	@IBOutlet weak var map: VTMapView!
	
	internal fileprivate(set) var delitingIsEnabled: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		map.delegate = self
		map.isUserInteractionEnabled = true
		map.addGestureRecognizer(gestureRecognizer(action: #selector(newAnnotationOnTap(gesture:))))
		
		let deleteButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(deletionMode))
		navigationItem.rightBarButtonItem = deleteButton
	}
	
	/**
	Adds annotation when gesture recognizer is triggered.
	*/
	@objc private func newAnnotationOnTap(gesture: UILongPressGestureRecognizer) {
		
		if gesture.state == .ended {
			map.createAnnotation()
		}
	}
}

// MARK: - Set up
extension MapViewController {
	
	@objc fileprivate func deletionMode() {
		
		delitingIsEnabled = !delitingIsEnabled
		
		if delitingIsEnabled {
			navigationItem.rightBarButtonItem?.title = "Done"
		} else {
			navigationItem.rightBarButtonItem?.title = "Edit"
		}
	}
	
	
	/**
	Creates a long press gesture recognizer for the map view.
	
	- Parameter action: Function to be triggered by the gesture.
	
	- Returns: Long press gesture recognizer.
	*/
	fileprivate func gestureRecognizer(action: Selector) -> UIGestureRecognizer {
		
		let gesture = UILongPressGestureRecognizer(target: self, action: action)
		return gesture
	}
}
