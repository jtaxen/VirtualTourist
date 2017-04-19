//
//  CoreDataTest.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-19.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import XCTest
import CoreData
@testable import VirtualTourist

class CoreDataTest: XCTestCase {
	
	var stack: CoreDataStack!
	var location: Location!
	var testImageParameters: [String: AnyObject]!
	var testImage: Image!

    override func setUp() {
        super.setUp()
		
		stack = CoreDataStack(modelName: "TestCoreData")
		testImageParameters = [
		]
		
		
    }
    
    override func tearDown() {
        super.tearDown()
    }
	
	func testSavingImage() {
		
		
		
		
	}
	
}
