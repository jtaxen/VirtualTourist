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
	private var parsedResults: [[String: AnyObject]]? = nil
	
	private init() {}
	
	func searchRequest(_ parameters: [String: AnyObject]?, searchReuestCompletionHandler: @escaping (_ result: [[String: AnyObject]]?, _ error: NSError?) -> Void ) -> URLSessionDataTask {
	
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
				searchReuestCompletionHandler(nil, error1)
				return
			}
			self.statusCode = (response as? HTTPURLResponse)?.statusCode
			
			self.parseResults(data!) { (results, error) in
				self.parsedResults = results
				searchReuestCompletionHandler(results, error)
			}
		}
		task.resume()
		return task
	}
	
	private func parseResults (_ data: Data, parseDataCompletionHandler: (_ results: [[String: AnyObject]]?, _ error: NSError?) -> Void) {
		
		var parsedData: [String: AnyObject]!
		do {
			parsedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject]
			parseDataCompletionHandler(parsedData["photo"] as? [[String: AnyObject]] , nil)
		} catch {
			/// Handle error≠
		}
		
	}
	
	func returnStatusCode() -> Int? {
		return statusCode
	}
	
	func returnParsedResults() -> [[String: AnyObject]]? {
		for item in parsedResults!{
			print("\(item)")
		}
		
		return parsedResults
	}
}
