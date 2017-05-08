//
//  LocationDataSource.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-05-08.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

class LocationDataSource {

	var locations: [Location]?
	static let shared = LocationDataSource()
	
	private init() {}
	
}
