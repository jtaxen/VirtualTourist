//
//  Service.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-28.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation
import UIKit

class Service: ServiceProtocol {
	
	static func downloadImageData(string: String?, completionHandler: @escaping (_ data: Data?) -> Void) {
		
		guard string != nil else {
			completionHandler(nil)
			return
		}
		guard let url = URL(string: string!) else {
			completionHandler(nil)
			return
		}
		do {
			let data = try Data(contentsOf: url)
			completionHandler(data)
		} catch {
			debugPrint(error)
			completionHandler(nil)
		}
	}
	
	static func turnDataIntoImage(data: Data?, completionHandler: @escaping (_ image: UIImage?) -> Void) {
		
		guard data != nil else {
			completionHandler(nil)
			return
		}
		let image = UIImage(data: data!)
		completionHandler(image)
	}
	
	static func createImageForStorage(fromData data: Data?, location: Location, image: [String : AnyObject]) -> Image? {
		
		var parameters: [String: AnyObject] = [:]
		
		parameters["location"] = location
		parameters["id"] = location.id as AnyObject
		parameters["owner"] = image["owner"]
		parameters["title"] = image["title"]
		parameters["url_m"] = image["url_m"]
		parameters["image_data"] = data as AnyObject
		
		return Image(parameters, context: (CoreDataStack.sharedInstance?.persistingContext)!)
	}
	
	static func returnUIImage(fromImage image: Image) -> UIImage? {
		
		guard let data = image.imageData else {
			return nil
		}
		
		let newImage = UIImage(data: data as Data)
		return newImage
	}
}
