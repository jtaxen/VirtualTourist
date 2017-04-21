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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		map.delegate = self
		map.isUserInteractionEnabled = true
		map.addGestureRecognizer(gestureRecognizer(action: #selector(newAnnotationOnTap(gesture:))))
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

/// MARK: - Set up
extension MapViewController {
	
	/**
	Creates a long press gesture recognizer for the map view.
	
	- Parameter action: Function to be triggered by the gesture.
	
	- Returns: Long press gesture recognizer.
	*/
	func gestureRecognizer(action: Selector) -> UIGestureRecognizer {
		
		let gesture = UILongPressGestureRecognizer(target: self, action: action)
		return gesture
	}
}
