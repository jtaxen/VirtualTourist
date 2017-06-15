//
//  FlickrClientConstants.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-12.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation

extension FlickrClient {

	/// URL parts for accessing the Flickr REST API.
	struct Constants {
	
		static let Scheme = "https"
		static let Host = "api.flickr.com"
		static let Path = "/services/rest/"
	}
	
	/// Flickr REST API parameter keys
	struct ParameterKeys {
	
		static let Method = "method"
		static let APIKey = "api_key"
		static let Latitude = "lat"
		static let Longitude = "lon"
		static let Radius = "radius"
		static let Extras = "extras"
		static let Format = "format"
		static let NoJSONCallback = "nojsoncallback"
		static let PerPage = "per_page"
		static let PageNumber = "page"
	}
	
	/// Flickr REST API parameter values
	struct ParameterValues {
		
		static let MethodSearch = "flickr.photos.search"
		static let APIKey = Keys.APIKey
		static let Extras = "url_m"
		static let Format = "json"
		static let NoJSONCallback = "1"
		static let PerPage = "18"
	}
	
	
	/// Parameter keys for the data returned from the server
	struct ImageProperties {
		
		static let ID = "id"
		static let Owner = "owner"
		static let Url = "url_m"
		static let Title = "title"
	}
	
	/// Time limit for server requests.
	struct Timer {
		
		static let Timeout: Double = 10
	}
	
	
	
}
