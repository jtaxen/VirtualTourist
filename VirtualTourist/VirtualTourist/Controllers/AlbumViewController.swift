//
//  AlbumViewController.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-21.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import UIKit
import MapKit

class AlbumViewController: UIViewController {

	@IBOutlet weak var map: MKMapView!
	@IBOutlet weak var collection: UICollectionView!
	@IBOutlet weak var newCollectionButton: UIButton!
	
	var images: [[String: AnyObject]]?
	
	private var centerPoint: CLLocationCoordinate2D!
	
	public func setCenter(_ point: CLLocationCoordinate2D) { centerPoint = point }
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		collection.delegate = self
		collection.register(AlbumCell.self, forCellWithReuseIdentifier: "albumCell")
		
		makeAPIRequest()
		
		prepareMap()
    }
	
	private func prepareMap() {
	
		map.isUserInteractionEnabled = false
		map.centerCoordinate = centerPoint
		let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
		let region = MKCoordinateRegion(center: centerPoint, span: span)
		map.setRegion(region, animated: true)
		
		let annotation = MKPointAnnotation()
		annotation.coordinate = centerPoint
		map.addAnnotation(annotation)
		
	}
	
	private func makeAPIRequest() {
		
		let parameters: [String: AnyObject] = [
			FlickrClient.ParameterKeys.APIKey: FlickrClient.ParameterValues.APIKey as AnyObject,
			FlickrClient.ParameterKeys.Extras: FlickrClient.ParameterValues.Extras as AnyObject,
			FlickrClient.ParameterKeys.Format: FlickrClient.ParameterValues.Format as AnyObject,
			FlickrClient.ParameterKeys.Method: FlickrClient.ParameterValues.MethodSearch as AnyObject,
			FlickrClient.ParameterKeys.Latitude: "\(centerPoint.latitude)" as AnyObject,
			FlickrClient.ParameterKeys.Longitude: "\(centerPoint.longitude)" as AnyObject,
			FlickrClient.ParameterKeys.NoJSONCallback: FlickrClient.ParameterValues.NoJSONCallback as AnyObject
		]
		
		_ = FlickrClient.sharedInstance.searchRequest(parameters) { (results, error) in
			
			guard error == nil else {
				debugPrint(error!)
				return
			}
			
			self.images = results
		}
	}
}
