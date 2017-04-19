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

    override func setUp() {
        super.setUp()
		
		stack = CoreDataStack(modelName: "TestCoreData")
		
		do {
			
		
		
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
