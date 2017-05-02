//
//  ServiceProtocol.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-28.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import Foundation
import UIKit

protocol ServiceProtocol {
	
	static func downloadImageData(string: String?, completionHandler: @escaping (_ data: Data?) -> Void)
	
	static func turnDataIntoImage(data: Data?, completionHandler: @escaping (_ image: UIImage?) -> Void)

}
