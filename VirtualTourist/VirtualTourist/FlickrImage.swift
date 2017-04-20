//
//  FlickrImage.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-18.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation

struct FlickrImage {

	init(_ parameters: [String: AnyObject]) {
	
		id = parameters["id"] as! String?
		owner = parameters["owner"] as! String?
		title = parameters["title"] as! String?
		url_m = parameters["url_m"] as! String?
	}
	
	let id: String?
	let owner: String?
	let title: String?
	let url_m: String?
	
}
