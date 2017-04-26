//
//  FlickrClient.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-12.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation

/// Class for handling communication with Flickr's server.
class FlickrClient {
	
	/// Singelton
	static let sharedInstance = FlickrClient()
	
	private let coreDataStack = CoreDataStack.sharedInstance!
	public private(set) var statusCode: Int? = nil
	public var parsedResults: [[String: AnyObject]]? = nil
	
	/// Default initializer is hidden.
	private init() {}
		
	/**
	Removes the parsed results from the latest request. This function is mainly for testing purposes.
	*/
	func removeParsedResults() {
		parsedResults = nil
	}
	
	/**
	Creates and performs a request to the Flickr server, and handles the results.
	
	- Parameter parameters: key-value pairs of search terms for the REST API. A valid API key is required.
	- Parameter searchRequestCompletionHandler: Completion handler for the request results.
	- Parameter result: The parsed results from the request.
	- Parameter error: Error if the request fails, nil otherwise.
	
	*/
	func searchRequest(_ parameters: [String: AnyObject]?, searchRequestCompletionHandler: @escaping (_ result: [[String: AnyObject]]?, _ error: NSError?) -> Void ) -> URLSessionDataTask {
	
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
				searchRequestCompletionHandler(nil, error1)
				return
			}
			self.statusCode = (response as? HTTPURLResponse)?.statusCode
			
			self.parseResults(data!, parseDataCompletionHandler: searchRequestCompletionHandler)
		}
		task.resume()
		return task
	}
	
	/**
	Parses data of JSON format into a Swift format, and returns it as an array of dictionaries.
	
	- Parameter data: JSON data to be parsed.
	- Parameter parseDataCompletionHandler: Completion handler for the parsed data.
	- Parameter results: An array of dictionaries containing the JSON data parsed in a Swift compatible format.
	- Parameter error: Error if the parsing fails, nil otherwise.
	*/
	public func parseResults (_ data: Data, parseDataCompletionHandler: (_ results: [[String: AnyObject]]?, _ error: NSError?) -> Void) {
		
		var parsedData: [String: AnyObject]
		do {
			parsedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
		} catch {
			debugPrint(error)
			parseDataCompletionHandler(nil, ErrorHandler.newError(code: 200))
			return
	
		}
		
		guard let photos = parsedData["photos"] as? [String: AnyObject] else {
			parseDataCompletionHandler(nil, ErrorHandler.newError(code: 201))
			return
		}
		
		guard let photo = photos["photo"] as? [[String: AnyObject]] else {
			parseDataCompletionHandler(nil, ErrorHandler.newError(code: 202))
			return
		}
		
		parseDataCompletionHandler(photo, nil)
	}
	
	/*
	Save image data in parsed result array to the core data stack. This function should obviously take an array of FlickrImage objects as an argument, and not refer to an internal variable.
	**/
	func saveImages() {
	
		guard parsedResults != nil else {
			let error = ErrorHandler.newError(code: 401)
			debugPrint(error)
			return
		}
		
		for item in parsedResults! {
			let image = FlickrImage(item)
			_ = Image(image, context: coreDataStack.context)
			print("")
		}
		
//		coreDataStack.save()
	}
}
