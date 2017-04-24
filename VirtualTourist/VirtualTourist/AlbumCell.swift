//
//  AlbumCell.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-24.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {
	
	private var spinner: UIActivityIndicatorView!
	public var image: UIImageView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.addSubview(image)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
