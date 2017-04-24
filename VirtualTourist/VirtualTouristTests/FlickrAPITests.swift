//
//  FlickrAPITests.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-12.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import XCTest
@testable import VirtualTourist

class FlickrAPITests: XCTestCase {
	
	static var parameters: [String: AnyObject]!
	
	override class func setUp() {
		super.setUp()
		
		parameters = [
			FlickrClient.ParameterKeys.Method: FlickrClient.ParameterValues.MethodSearch as AnyObject,
			FlickrClient.ParameterKeys.Extras: FlickrClient.ParameterValues.Extras as AnyObject,
			FlickrClient.ParameterKeys.Format: FlickrClient.ParameterValues.Format as AnyObject,
			FlickrClient.ParameterKeys.NoJSONCallback: FlickrClient.ParameterValues.NoJSONCallback as AnyObject,
			FlickrClient.ParameterKeys.APIKey: FlickrClient.ParameterValues.APIKey as AnyObject,
			FlickrClient.ParameterKeys.Latitude: "13.13" as AnyObject,
			FlickrClient.ParameterKeys.Longitude: "56.56" as AnyObject
		]
	}
	
	override class func tearDown() {
		FlickrClient.sharedInstance.removeParsedResults()
		super.tearDown()
	}
	
	/// All tests in one function, because of asynchronous chaos.
	func testServerCompletion() {
		
		let expectation = self.expectation(description: "Server returns data")
		
		_ = FlickrClient.sharedInstance.searchRequest(FlickrAPITests.parameters) { (results, error) in
			let statusCode = FlickrClient.sharedInstance.statusCode
			XCTAssertNotNil(statusCode)
			
			guard error == nil else {
				debugPrint(error!)
				XCTFail("Server request returned an error.")
				return
			}
			
			guard results != nil else {
				XCTFail("No results returned")
				return
			}
			
			expectation.fulfill()
		}
		self.waitForExpectations(timeout: 20.0) { (error) in
			guard error == nil else {
				debugPrint(error!)
				return
			}
			
			guard FlickrClient.sharedInstance.parsedResults != nil else {
				XCTFail("Parsed results do not exist")
				return
			}
		}
	}
}
