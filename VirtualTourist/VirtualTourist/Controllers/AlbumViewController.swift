//
//  AlbumViewController.swift
//  VirtualTourist
//
//  Created by ÅF Jacob Taxén on 2017-04-21.
//  Copyright © 2017 Jacob Taxén. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class AlbumViewController: UIViewController {
	
	@IBOutlet weak var map: MKMapView!
	@IBOutlet weak var collection: UICollectionView!
	@IBOutlet weak var newCollectionButton: UIButton!
	@IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
	
	internal var numberOfCells: Int = 0
	internal var cellsToBeDeleted: [IndexPath] = []
	
	public var currentAnnotation: VTAnnotation! {
		didSet {
			centerPoint = currentAnnotation.coordinate
		}
	}
	
	internal var modelImages: [Image?] = []
	internal var images: [UIImage?] = []
	
	internal var imageData: [String: AnyObject]?
	
	/// The point on which the map is centered.
	internal var centerPoint: CLLocationCoordinate2D!
	
	// MARK: - View did load
	override func viewDidLoad() {
		super.viewDidLoad()
		
		prepareMap()
		prepareCollectionView()
		
		
		if currentAnnotation.location.firstTimeOpened {
			makeAPIRequest()
		}
		modelImages = CoreDataStack.sharedInstance!.fetchImages(fromLocation: currentAnnotation.location)!
		for item in modelImages {
			Service.turnDataIntoImage(data: item?.imageData) { (processedImageData) in
				DispatchQueue.main.async {
					self.images.append(processedImageData)
				}
			}
		}
	}
}

// MARK: - Handle server requests and images.
extension AlbumViewController {
	
	/// Makes a request to the Flickr server based on the location of the pin.
	internal func makeAPIRequest() {
		
		let parameters: [String: AnyObject] = [
			FlickrClient.ParameterKeys.APIKey: FlickrClient.ParameterValues.APIKey as AnyObject,
			FlickrClient.ParameterKeys.Extras: FlickrClient.ParameterValues.Extras as AnyObject,
			FlickrClient.ParameterKeys.Format: FlickrClient.ParameterValues.Format as AnyObject,
			FlickrClient.ParameterKeys.Method: FlickrClient.ParameterValues.MethodSearch as AnyObject,
			FlickrClient.ParameterKeys.Latitude: "\(centerPoint.latitude)" as AnyObject,
			FlickrClient.ParameterKeys.Longitude: "\(centerPoint.longitude)" as AnyObject,
			FlickrClient.ParameterKeys.NoJSONCallback: FlickrClient.ParameterValues.NoJSONCallback as AnyObject,
			FlickrClient.ParameterKeys.PerPage: FlickrClient.ParameterValues.PerPage as AnyObject
		]
		
		_ = FlickrClient.sharedInstance.searchRequest(parameters) { (results, error) in
			
			guard error == nil else {
				debugPrint(error!)
				return
			}
			
			guard results != nil else {
				debugPrint(ErrorHandler.newError(code: 110))
				return
			}
			
			self.numberOfCells = results!.count
			DispatchQueue.main.async {
				self.collection.reloadData()
			}
			
			for image in results! {
				
				/// Download image
				Service.downloadImageData(string: (image["url_m"] as! String)) { (data) in
					if data != nil {
						let newImage = UIImage(data: data!)
						self.images.append(newImage)
						DispatchQueue.main.async {
							self.collection.reloadData()
						}
						
						self.modelImages.append(Service.createImageForStorage(fromData: data, location: self.currentAnnotation.location, image: image))
					}
				}
			}
			DispatchQueue.main.async {
				self.collection.reloadData()
				CoreDataStack.sharedInstance?.save()
			}
		}
	}
}


// MARK: - Restructure image collection
internal extension AlbumViewController {
	
	@objc func deleteChosenImages() {
		
		for index in cellsToBeDeleted {
			if index.row < images.count {
				images.remove(at: index.row)
			}
		}
		collection.reloadData()
	}
}
