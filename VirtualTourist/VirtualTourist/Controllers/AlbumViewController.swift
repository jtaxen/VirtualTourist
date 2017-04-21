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
	
	private var centerPoint: CLLocationCoordinate2D!
	
	public func setCenter(_ point: CLLocationCoordinate2D) { centerPoint = point }
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
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
}
