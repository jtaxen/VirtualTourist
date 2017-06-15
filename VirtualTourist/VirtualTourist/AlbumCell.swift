//
//  AlbumCell.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-24.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {
	
	public var spinner: UIActivityIndicatorView!
	private var imageView: UIImageView!
	
	// MARK: - Initializer
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		imageView = UIImageView(frame: contentView.frame)
		imageView.contentMode = UIViewContentMode.scaleAspectFit
		contentView.addSubview(imageView)

		spinner = createSpinner()
		
		let mask = UIView(frame: self.bounds)
		mask.backgroundColor = UIColor.white
		mask.alpha = 1.0
		self.mask = mask
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/**
	Add image to cell
	- Parameter image: image.
	*/
	public func addImage(_ image: UIImage?) {
		imageView.image = image
		if spinner.isAnimating {
			spinner.stopAnimating()
		}
	}
	
	/**
	Creates an UIIndicatorView to mark that an image is not yet download.
	
	- Returns: An UIIndicatorView
	*/
	private func createSpinner() -> UIActivityIndicatorView {
		
		let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
		spinner.hidesWhenStopped = true
		
		let x = contentView.frame.width.subtracting(spinner.frame.width).multiplied(by: CGFloat(0.5))
		let y = contentView.frame.height.subtracting(spinner.frame.height).multiplied(by: CGFloat(0.5))
		let newFrame = CGRect(x: x, y: y, width: spinner.frame.width, height: spinner.frame.height)
		spinner.frame = newFrame
		
		return spinner
	}
}
