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
	internal fileprivate(set) var deletingIsEnabled: Bool = false
	
	let appDelegate = UIApplication.shared.delegate as! AppDelegate
	//	var locations: [Location]?
	
	// MARK: - View did load
	override func viewDidLoad() {
		super.viewDidLoad()
		
		LocationDataSource.shared.locations = CoreDataStack.sharedInstance?.fetchLocations()
		
		
		// Set up map view
		map.delegate = self
		map.isUserInteractionEnabled = true
		map.addGestureRecognizer(gestureRecognizer(action: #selector(newAnnotationOnTap(gesture:))))
		
		CoreDataStack.sharedInstance?.persistingContext.performAndWait {
			if LocationDataSource.shared.locations != nil {
				for location in LocationDataSource.shared.locations! {
					let annotation = VTAnnotation(location: location)
					annotation.coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude), longitude: Double(location.longitude))
					self.map.addAnnotation(annotation)
				}
			}
		}
		
		deletionIndicationView()
		
		// Add bar button to switch between regular mode and deletion mode
		let deleteButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(deletionMode))
		navigationItem.rightBarButtonItem = deleteButton
		
	}
	
	/**
	Adds annotation when gesture recognizer is triggered
	*/
	@objc private func newAnnotationOnTap(gesture: UILongPressGestureRecognizer) {
		
		if gesture.state == .began {
			CoreDataStack.sharedInstance?.persistingContext.performAndWait {
				let newAnnotation = self.map.createAnnotation()
				let newLocation = Location(id: UUID().uuidString, image: nil, coordinate: newAnnotation.coordinate, context: CoreDataStack.sharedInstance!.persistingContext)
				newLocation?.firstTimeOpened = true
				newAnnotation.location = newLocation!
			}
			CoreDataStack.sharedInstance?.save()
		}
	}
	
	@objc internal func deleteAllLocations() {
		
		let alert = UIAlertController(title: "Remove all locations", message: "Are you sure you want to delete all your locations? (You cannot undo this action.)", preferredStyle: .actionSheet)
		let remove = UIAlertAction(title: "Delete", style: .destructive) { (action) in
			
			do {
				try CoreDataStack.sharedInstance?.dropAllData()
				CoreDataStack.sharedInstance?.save()
				LocationDataSource.shared.locations = []
				self.map.removeAnnotations(self.map.annotations)
			} catch {
				debugPrint(error)
			}
		}
		
		let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		alert.addAction(cancel)
		alert.addAction(remove)
		present(alert, animated: true, completion: nil)
		
	}
}

// MARK: - Set up
extension MapViewController {
	
	/// Action associated with the right bar button item. Toggles the deletingIsEnabled variable and changes the title of the button.
	@objc fileprivate func deletionMode() {
		
		deletingIsEnabled = !deletingIsEnabled
		
		if deletingIsEnabled {
			presentDeletionIndicationView()
			navigationItem.rightBarButtonItem?.title = "Done"
			navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete all", style: .done, target: self, action: #selector(deleteAllLocations))
			
		} else {
			removeDeletionIndicationView()
			CoreDataStack.sharedInstance?.save()
			navigationItem.rightBarButtonItem?.title = "Edit"
			navigationItem.leftBarButtonItem = nil
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
	
	fileprivate func deletionIndicationView() {
		
		let deletionView = UILabel(frame: CGRect(x: CGFloat(0), y: view.frame.height, width: view.frame.width, height: view.frame.height.multiplied(by: CGFloat(0.1))))
		deletionView.backgroundColor = UIColor(colorLiteralRed: 117/256, green: 8/256, blue: 28/256, alpha: 1)
		deletionView.text = "Tap pin to delete it"
		deletionView.font = UIFont(name: "Futura", size: CGFloat(20))
		deletionView.textColor = UIColor.white
		deletionView.textAlignment = NSTextAlignment.center
		view.addSubview(deletionView)
	}
	
	private func presentDeletionIndicationView() {
		
		let deletionView = view.subviews.last!
		let newFrame = CGRect(x: CGFloat(0), y: view.frame.height.multiplied(by: CGFloat(0.9)) , width: view.frame.width, height: view.frame.height.multiplied(by: CGFloat(0.1)))
		
		deletionView.layoutIfNeeded()
		UIView.animate(withDuration: 0.2) {
			deletionView.frame = newFrame
			deletionView.layoutIfNeeded()
		}
	}
	
	private func removeDeletionIndicationView() {
		
		let deletionView = view.subviews.last!
		let newFrame = CGRect(x: CGFloat(0), y: view.frame.height, width: view.frame.width, height: view.frame.height.multiplied(by: CGFloat(0.1)))
		deletionView.layoutIfNeeded()
		UIView.animate(withDuration: 0.2) {
			deletionView.frame = newFrame
			deletionView.layoutIfNeeded()
		}
	}
}
