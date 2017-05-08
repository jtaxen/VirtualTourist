//
//  AppDelegate.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-11.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
		LocationDataSource.shared.locations = CoreDataStack.sharedInstance?.fetchLocations()
		print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
		return true
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		CoreDataStack.sharedInstance!.save()
	}
	
	
	func applicationWillTerminate(_ application: UIApplication) {
		CoreDataStack.sharedInstance!.save()
		print("Bye.. 👋")
	}
}

