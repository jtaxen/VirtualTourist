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

	/**
	Add image to cell
	- Parameter image: image.
	*/
	public func addImage(_ image: UIImage?) {
	
		let imageView = UIImageView(image: image)
		imageView.contentMode = UIViewContentMode.scaleAspectFit
		contentView.addSubview(imageView)
	}
}
