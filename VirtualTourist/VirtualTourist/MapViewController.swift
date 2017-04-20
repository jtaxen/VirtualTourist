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
		map.isUserInteractionEnabled = true
		map.addGestureRecognizer(gestureRecognizer(action: #selector(newAnnotationOnTap)))
	}
	
	@objc private func newAnnotationOnTap() {
		map.createAnnotation()
	}
}

// MARK: - Set up
extension MapViewController {
	
	func gestureRecognizer(action: Selector) -> UIGestureRecognizer {
		
		let gesture = UILongPressGestureRecognizer(target: self, action: action)
		return gesture
	}
}
