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
			return}
		let image = UIImage(data: data!)
		completionHandler(image)
	}
}
