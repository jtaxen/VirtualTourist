//
//  AlbumNavigationController.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-21.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import UIKit
import CoreLocation

class AlbumNavigationController: UINavigationController {

	public var annotationCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
