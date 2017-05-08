//
//  ErrorHandler.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-12.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation

struct ErrorHandler {

	/// Singelton
	static let sharedInstance = ErrorHandler()
	
	/// Hides default initializer
	private init() {}
	
	/**
	Checks the server response for errors.
	
	- Parameter withData: Data returned from the server.
	- Parameter inResponse: Metadata associated with the server response.
	- Parameter forError: Error regarding the response.
	
	- Returns: If an error is found, it is returned together with its corresponding error code. If everything is good, nil is returned.
	*/
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
	
	/**
	Generates an error based on an error code.
	
	- Parameter code: The error code representing the error.
	
	- Returns: An error with the following information:
	* Error code representing the error.
	* Error domain.
	* Description of the error.
	*/
	static func newError(code: Int) -> NSError {
	
		let message = errorMessage(errorCode: code)
		
		let userInfo = [NSLocalizedDescriptionKey: message["message"] as Any]
		let error = NSError(domain: message["domain"]!, code: code, userInfo: userInfo)
		return error
		
	}
	
}
