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
	
	/// When true, annotations are deleted when touched, instead of pushing the album view controller.
	internal fileprivate(set) var delitingIsEnabled: Bool = false
	
	let appDelegate = UIApplication.shared.delegate as! AppDelegate
	
	// MARK: - View did load
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Set up map view
		map.delegate = self
		map.isUserInteractionEnabled = true
		map.addGestureRecognizer(gestureRecognizer(action: #selector(newAnnotationOnTap(gesture:))))
		
		for location in appDelegate.locations {
			let annotation = MKPointAnnotation()
			annotation.coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude), longitude: Double(location.longitude))
			map.addAnnotation(annotation)
		}
		
		// Add bar button to switch between regular mode and deletion mode
		let deleteButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(deletionMode))
		navigationItem.rightBarButtonItem = deleteButton
	}
	
	/**
	Adds annotation when gesture recognizer is triggered
	*/
	@objc private func newAnnotationOnTap(gesture: UILongPressGestureRecognizer) {
		
		if gesture.state == .ended {
			let newAnnotation = map.createAnnotation()
			let newLocation = Location(id: UUID().uuidString, image: nil, coordinate: newAnnotation.coordinate, context: (CoreDataStack.sharedInstance?.context)!)
			appDelegate.locations.append(newLocation!)
		}
	}
}

// MARK: - Set up
extension MapViewController {
	
	/// Action associated with the right bar button item. Toggles the delitingIsEnabled variable and changes the title of the button.
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
