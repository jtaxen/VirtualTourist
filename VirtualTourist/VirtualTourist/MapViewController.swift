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
	
	@IBOutlet weak var map: VTMapView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		map.delegate = self
		map.addGestureRecognizer(gestureRecognizer(action: #selector(newAnnotationOnTap)))
	}
	
	@objc private func newAnnotationOnTap() {
	}
}

// MARK: - Set up
extension MapViewController {
	
	func gestureRecognizer(action: Selector) -> UIGestureRecognizer {
		
//		let gesture = UILongPressGestureRecognizer(target: self, action: action)
		let gesture = UITapGestureRecognizer(target: self, action: action)
//		gesture.minimumPressDuration = 1.5
		gesture.numberOfTapsRequired = 1
		gesture.numberOfTouchesRequired = 1
//		gesture.allowableMovement = CGFloat(15)
		
		print(gesture.location(in: map))
		return gesture
	}
}
