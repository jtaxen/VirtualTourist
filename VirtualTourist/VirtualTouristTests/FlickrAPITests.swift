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
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func testServerReturnsAStatusCode() {
		var statusCode: String? = FlickrClient.sharedInstance.returnStatusCode()
		XCTAssertNotNil(statusCode)
	}
}
