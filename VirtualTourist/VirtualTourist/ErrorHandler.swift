//
//  ErrorHandler.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-12.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation

struct ErrorHandler {

	static let sharedInstance = ErrorHandler()
	
	private init() {}
	
	static func checkServerResponse(withData data: Data?, inResponse response: URLResponse?, forError error: NSError?) -> NSError? {
	
		/// Check if error was returned
		guard error == nil else { return error }
		
		/// Make sure that the server returns a 200-status code
		guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
		
			let userInfo = [NSLocalizedDescriptionKey: "The server did not return any status code."]
			return NSError(domain: "serverRequestError", code: 100, userInfo: userInfo)
		}
		
		guard statusCode >= 200 && statusCode <= 299 else {
			
			let userInfo = [NSLocalizedDescriptionKey: "The server returned the status code \(statusCode)."]
			let code = 100 + statusCode / 100
			return NSError(domain: "serverRequestError", code: code, userInfo: userInfo)
		}
		
		print("The server returned the status code \(statusCode)")
		
		/// Make sure data was returned
		
		guard data != nil else {
			
			let userInfo = [NSLocalizedDescriptionKey: "The server did not return any data."]
			return NSError(domain: "serverRequestError", code: 110, userInfo: userInfo)
		}
		
		return nil
	}
	
}
