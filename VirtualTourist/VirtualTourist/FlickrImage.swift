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
	
		id = parameters["id"]
		owner = parameters["owner"]
		title = parameters["title"]
		url_m = parameters["url_m"]
		
	}
	
	let id: AnyObject?
	let owner: AnyObject?
	let title: AnyObject?
	let url_m: AnyObject?
	
}
