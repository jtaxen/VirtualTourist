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
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		spinner = createSpinner()
		spinner.startAnimating()
		backgroundView = spinner
		
		imageView = UIImageView(frame: contentView.frame)
		imageView.contentMode = UIViewContentMode.scaleAspectFit
		contentView.addSubview(imageView)
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
//		spinner.stopAnimating()
		
	}
	
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
