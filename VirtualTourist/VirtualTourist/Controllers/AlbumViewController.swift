//
//  AlbumViewController.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-21.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class AlbumViewController: UIViewController {
	
	@IBOutlet weak var map: MKMapView!
	@IBOutlet weak var collection: UICollectionView!
	@IBOutlet weak var newCollectionButton: UIButton!
	@IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
	
	public var currentAnnotation: VTAnnotation! {
		didSet {
			centerPoint = currentAnnotation.coordinate
		}
	}
	
	internal var images: [UIImage?] = [] {
		didSet {
			collection.reloadData()
		}
	}
	
	/// The point on which the map is centered.
	internal var centerPoint: CLLocationCoordinate2D!
	
	// MARK: - View did load
	override func viewDidLoad() {
		super.viewDidLoad()
		
		prepareMap()
		prepareCollectionView()
	}
}

// MARK: - Set up view
extension AlbumViewController {
	
	/// Set up the map view
	internal func prepareMap() {
		
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
	internal func prepareCollectionView() {
		
		collection.dataSource = self
		collection.delegate = self
		collection.register(AlbumCell.self, forCellWithReuseIdentifier: "albumCell")
	}
}

/// MARK: - Handle server requests and images.
extension AlbumViewController {

	/// Makes a request to the Flickr server based on the location of the pin.
	internal func makeAPIRequest() {
		
		let parameters: [String: AnyObject] = [
			FlickrClient.ParameterKeys.APIKey: FlickrClient.ParameterValues.APIKey as AnyObject,
			FlickrClient.ParameterKeys.Extras: FlickrClient.ParameterValues.Extras as AnyObject,
			FlickrClient.ParameterKeys.Format: FlickrClient.ParameterValues.Format as AnyObject,
			FlickrClient.ParameterKeys.Method: FlickrClient.ParameterValues.MethodSearch as AnyObject,
			FlickrClient.ParameterKeys.Latitude: "\(centerPoint.latitude)" as AnyObject,
			FlickrClient.ParameterKeys.Longitude: "\(centerPoint.longitude)" as AnyObject,
			FlickrClient.ParameterKeys.NoJSONCallback: FlickrClient.ParameterValues.NoJSONCallback as AnyObject,
			FlickrClient.ParameterKeys.PerPage: FlickrClient.ParameterValues.PerPage as AnyObject
		]
		
		_ = FlickrClient.sharedInstance.searchRequest(parameters) { (results, error) in
			
			guard error == nil else {
				debugPrint(error!)
				return
			}
			
			guard results != nil else {
				debugPrint(ErrorHandler.newError(code: 110))
				return
			}
			
			self.currentAnnotation.addImages(FlickrClient.sharedInstance.saveAsImages(results!, forLocation: self.currentAnnotation.location))
		}
	}
}
