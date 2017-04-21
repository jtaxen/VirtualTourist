//
//  ErrorHandlerErrors.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-12.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation

internal extension ErrorHandler {

	/**
	Creates an error message based on the error code.
	
	- Parameter errorCode: Error code representing the error.
	
	- Returns: A dictionary with two entries:
	* The key *domain* contains the error domain.
	* The key *message* contains a description of the error for debugging purposes.
	*/
	static func errorMessage(errorCode code: Int) -> [String: String] {
		
		var errorInfo: [String: String] = [:]
		var message: String = ""
		
		/// Server request error
		if code >= 100 && code <= 199 {
			errorInfo["domain"] = "serverRequestDomain"
			
			switch code {
			case 100: message = "Server did not return any status code."
			case 101: message = "Server returned 1xx - Informal response."
			case 103: message = "Server returned 3xx - Redirection respone."
			case 104: message = "Server returned 4xx - Client error response."
			case 105: message = "Server returned 5xx - Server error response."
			case 110: message = "No data was returned."
			default: message = "Unknown server request error."
			}
		}
		
		/// JSON parsing error
		if code >= 200 && code <= 299 {
			errorInfo["domain"] = "jsonParsingError"
			
			switch code {
			case 200: message = "JSON parsing failed."
			case 201: message = "Could not find photos in JSON results."
			case 202: message = "Could not find photo in JSON results."
			default: message = "Unknown parsing error."
			}
		}
		
		errorInfo["message"] = message
		return errorInfo
	}
}
