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
		
			return newError(code: 100)
		}
		
		guard statusCode >= 200 && statusCode <= 299 else {
			
			debugPrint("The server returned the status code \(statusCode).")
			let code = 100 + statusCode / 100
			return newError(code: code)
		}
		
		print("The server returned the status code \(statusCode)")
		
		/// Make sure data was returned
		
		guard data != nil else {
			
			return newError(code: 110)
		}
		
		return nil
	}
	
	static func newError(code: Int) -> NSError {
	
		let message = errorMessage(errorCode: code)
		
		let userInfo = [NSLocalizedDescriptionKey: message["message"]]
		let error = NSError(domain: message["domain"]!, code: code, userInfo: userInfo)
		return error
		
	}
	
}
