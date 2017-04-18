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
	
	var parameters: [String: AnyObject]!
	
	override func setUp() {
		super.setUp()
		
		parameters = [
			FlickrClient.ParameterKeys.Extras: FlickrClient.ParameterValues.Extras as AnyObject,
			FlickrClient.ParameterKeys.Format: FlickrClient.ParameterValues.Format as AnyObject,
			FlickrClient.ParameterKeys.NoJSONCallback: FlickrClient.ParameterValues.NoJSONCallback as AnyObject,
			FlickrClient.ParameterKeys.APIKey: FlickrClient.ParameterValues.APIKey as AnyObject
		]
	}
	
	override func tearDown() {
		parameters = nil
		super.tearDown()
	}
	
	/// All tests in one function, because of asynchronous chaos.
	func testServerCompletion() {
		_ = FlickrClient.sharedInstance.searchRequest(parameters) { (results, error) in
			let statusCode = FlickrClient.sharedInstance.returnStatusCode()
			XCTAssertNotNil(statusCode)
			
			let data: [[String: AnyObject]]? = FlickrClient.sharedInstance.returnParsedResults()
			XCTAssertNotNil(results)
			XCTAssertNotNil(data)
			XCTAssertNil(error)
			
			guard data != nil && results != nil else { return }
		}
	}
}
