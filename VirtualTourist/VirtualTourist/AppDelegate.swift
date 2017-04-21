//
//  AppDelegate.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-11.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	func exampleImage() -> [String: AnyObject] {
	
		return [
			"id": 33272940574 as AnyObject,
			"owner": "76282789@N08" as AnyObject,
			"secret": "5419d1ea9c" as AnyObject,
			"server": 2864 as AnyObject,
			"farm": 3 as AnyObject,
			"title": "Amadeus again. Loves toys." as AnyObject,
			"ispublic": 1 as AnyObject,
			"isfriend": 0 as AnyObject,
			"isfamily": 0 as AnyObject,
			"url_m": "https://farm3.staticflickr.com/2864/33272940574_5419d1ea9c.jpg" as AnyObject,
			"height_m": "500" as AnyObject,
			"width_m": "400" as AnyObject
		]
	}
}

