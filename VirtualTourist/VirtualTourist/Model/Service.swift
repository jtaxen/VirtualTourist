//
//  Service.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-28.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation
import UIKit

class Service {
	
	static func downloadImageData( imagePath: String, completionHandler: @escaping (_ imageData: Data?, _ errorString: String?) -> Void) {
		let session = URLSession.shared
		let imgURL = URL(string: imagePath)
		let request: URLRequest = URLRequest(url: imgURL!)
		
		let task = session.dataTask(with: request) { data, response, downloadError in
			
			if downloadError != nil {
				completionHandler(nil, "Could not download image \(imagePath)")
			} else {
				completionHandler(data, nil)
			}
		}
		task.resume()
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
		CoreDataStack.sharedInstance?.persistingContext.performAndWait {
		parameters["location"] = location
		parameters["id"] = location.id as AnyObject
		parameters["owner"] = image["owner"]
		parameters["title"] = image["title"]
		parameters["url_m"] = image["url_m"]
		parameters["image_data"] = data as AnyObject
		}
		return Image(parameters, context: CoreDataStack.sharedInstance!.persistingContext)
	}
	
	static func returnUIImage(fromImage image: Image) -> UIImage? {
		
		guard let data = image.imageData else {
			return nil
		}
		
		let newImage = UIImage(data: data as Data)
		return newImage
	}
}
