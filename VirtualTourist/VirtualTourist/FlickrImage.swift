//
//  FlickrImage.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-18.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation
import UIKit

struct FlickrImage {

	/**
	Initializer of FlickrImage.
	- Parameter parameters: Dictionary
	*/
	init(_ parameters: [String: AnyObject]) {
	
		id = parameters["id"] as! String?
		owner = parameters["owner"] as! String?
		title = parameters["title"] as! String?
		url_m = parameters["url_m"] as! String?
		data = downloadImage(urlString: url_m)
		image = convertToUIImage(data: data)
	}
	
	let id: String?
	let owner: String?
	let title: String?
	let url_m: String?
	private(set) var data: Data?
	private(set) var image: UIImage?
	
	/**
	Converts Data to UIImage.
	- Parameter data: image data downloaded from an url path through downloadImage(String?). This needs to be converted to an UIImage in order for it to be shown by the UI.
	- Returns: UIImage that can be shown by the UI.
	*/
	public func convertToUIImage(data: Data?) -> UIImage? {
		
		guard data != nil else { return nil }
		let image = UIImage(data: data!)
		return image
	}
	
	/**
	Given the media url path from the Flickr server request results, this function opens the path and downloads the image. The image is returned as a Data object, in order for it to be storeable in the core data stack. The url path does not have to be converted to a URL object before being used as an argument.
	- Parameter urlString: The url of the image as a string.
	- Returns: The downloaded image as a Data object. This object is conveniently converted into an UIImage using convertToUIImage(Data?).
	*/
	public mutating func downloadImage(urlString string: String?) -> Data? {
		
		guard string != nil else {
			debugPrint(ErrorHandler.newError(code: 301))
			return nil
		}
		
		let url = URL(string: string!)!
		var imageData: Data? = nil
		
		do {
			imageData = try Data(contentsOf: url)
		} catch {
			debugPrint(error)
			debugPrint(ErrorHandler.newError(code: 301))
			return nil
		}
		
		return imageData
	}
}
