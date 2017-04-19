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
			FlickrClient.ParameterKeys.Extras: FlickrClient.ParameterValues.Extras as AnyObject,
			FlickrClient.ParameterKeys.Format: FlickrClient.ParameterValues.Format as AnyObject,
			FlickrClient.ParameterKeys.NoJSONCallback: FlickrClient.ParameterValues.NoJSONCallback as AnyObject,
			FlickrClient.ParameterKeys.APIKey: FlickrClient.ParameterValues.APIKey as AnyObject
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
			let statusCode = FlickrClient.sharedInstance.getStatusCode()
			XCTAssertNotNil(statusCode)
			
			guard error == nil else {
				debugPrint(error!)
				XCTFail("Server request returned an error.")
				return
			}
			
			XCTAssertNotNil(results)
			expectation.fulfill()
		}
		self.waitForExpectations(timeout: 20.0) { (error) in
			guard error == nil else {
				debugPrint(error!)
				return
			}
		}
	}
	
	func testParsedResultsAreSaved() {
		
		guard FlickrClient.sharedInstance.getParsedResults() != nil else {
			XCTFail("Parsed results do not exist")
			return
		}
	
		for item in FlickrClient.sharedInstance.getParsedResults()! {
			for (key, value) in item {
				print("\(key): \(value)")
			}
		}
	}
}
