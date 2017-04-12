//
//  FlickrClient.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-12.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation

class FlickrClient {
	
	static let sharedInstance = FlickrClient()
	
	private var statusCode: Int? = nil
	
	private init() {}
	
	func searchRequest(_ parameters: [String: AnyObject]?, searchReuestCompletionHandler: @escaping (_ result: [[String: AnyObject]], _ error: NSError?) -> Void ) -> URLSessionDataTask {
	
		var urlComponents = URLComponents()
		urlComponents.scheme = Constants.Scheme
		urlComponents.host = Constants.Host
		urlComponents.path = Constants.Path
		
		if parameters != nil {
			urlComponents.queryItems = []
			for (key, value) in parameters! {
				let item = URLQueryItem(name: key, value: value as? String)
				urlComponents.queryItems?.append(item)
			}
		}
		
		let request = NSMutableURLRequest(url: urlComponents.url!)
		request.timeoutInterval = Timer.Timeout
		request.url = urlComponents.url
		
		print("Request being sent: \(request.url!).")
		
		let session = URLSession.shared
		let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
			
			let error1 = ErrorHandler.checkServerResponse(withData: data, inResponse: response, forError: error as NSError?)
			
			guard error1 == nil else {
				debugPrint(error1!)
				return
			}
			
			print("\(response as? HTTPURLResponse)?.statusCode)")
			self.statusCode = (response as? HTTPURLResponse)?.statusCode
		}
		task.resume()
		return task
	}
	
	func returnStatusCode() -> Int? {
		return statusCode
	}
}
