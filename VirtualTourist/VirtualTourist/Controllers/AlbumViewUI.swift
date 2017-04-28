//
//  AlbumViewUI.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-28.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation
import UIKit

internal extension AlbumViewController {

	func createSpinner(superview view: UIView) -> UIActivityIndicatorView {
		
		let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
		spinner.hidesWhenStopped = true
		
		let x = view.frame.width.subtracting(spinner.frame.width).multiplied(by: CGFloat(0.5))
		let y = view.frame.height.subtracting(spinner.frame.height).multiplied(by: CGFloat(0.5))
		let newFrame = CGRect(x: x, y: y, width: spinner.frame.width, height: spinner.frame.height)
		spinner.frame = newFrame
		
		return spinner
	}
}