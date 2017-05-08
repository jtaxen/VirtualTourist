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
	
	public var numberOfCells: Int = 0
	internal var pageNumber: Int = 1 {
		didSet {
			if pageNumber > numberOfPages && numberOfPages >= 1 {
				pageNumber = 1
			}
		}
	}
	internal var numberOfPages: Int! {
		willSet {
			currentAnnotation.location.numberOfPages = Int32(newValue)
		}
	}
	internal var deletionMode = false
	internal var cellsToBeDeleted: [IndexPath] = [] {
		didSet {
			// As long as the number of elements are greater than zero, the delete button should be visible.
			if deletionMode && cellsToBeDeleted.count == 0 {
				deletionMode = false
				removeDeleteButton()
			} else if !deletionMode && cellsToBeDeleted.count > 0 {
				deletionMode = true
				presentDeleteButton()
			}
		}
	}
	
	public var currentAnnotation: VTAnnotation! {
		didSet {
			centerPoint = currentAnnotation.coordinate
		}
	}
	
	public var modelImages: [Image?] = []
	internal var images: [UIImage?] = []
	internal var imageData: [String: AnyObject]?
	
	/// The point on which the map is centered.
	internal var centerPoint: CLLocationCoordinate2D!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	// MARK: - View did load
	override func viewDidLoad() {
		super.viewDidLoad()
		
		reloadData()
		collection.reloadData()
		
		numberOfPages = Int(currentAnnotation.location.numberOfPages)
		pageNumber = Int(currentAnnotation.location.page)
		
		newCollectionButton.setTitle("Get new collection of images", for: .normal)
		newCollectionButton.titleLabel?.font = UIFont(name: "Futura", size: CGFloat(17))
		newCollectionButton.setTitleColor(UIColor.blue, for: .normal)
		newCollectionButton.addTarget(self, action: #selector(newCollection), for: .touchUpInside)
		
		prepareMap()
		prepareCollectionView()
		
		if currentAnnotation.location.firstTimeOpened {
			currentAnnotation.location.firstTimeOpened = false
			makeAPIRequest()
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
			FlickrClient.ParameterKeys.PerPage: FlickrClient.ParameterValues.PerPage as AnyObject,
			FlickrClient.ParameterKeys.PageNumber: "\(pageNumber)" as AnyObject
		]
		
		_ = FlickrClient.sharedInstance.searchRequest(parameters) { (results, pages, error) in
			
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
			
			self.numberOfPages = pages
			
			for image in results! {
				
				/// Download image
				Service.downloadImageData(string: (image["url_m"] as! String)) { (data) in
					if data != nil {
						self.modelImages.append(Service.createImageForStorage(fromData: data, location: self.currentAnnotation.location, image: image))
						self.reloadData()
					}
				}
			}
			DispatchQueue.main.async {
				self.reloadData()
				self.collection.reloadData()
			}
		}
	}
	
	func reloadData() {
		for item in modelImages {
			Service.turnDataIntoImage(data: item?.imageData! as Data?) { (processedImageData) in
				DispatchQueue.main.async {
					self.images.append(processedImageData)
				}
			}
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		CoreDataStack.sharedInstance?.save()
	}
}


// MARK: - Restructure image collection
internal extension AlbumViewController {
	
	@objc func deleteChosenImages() {
		
		numberOfCells = numberOfCells - cellsToBeDeleted.count
		
		for index in cellsToBeDeleted {
			if index.row < images.count {
				images.remove(at: index.row)
				CoreDataStack.sharedInstance?.context.delete(modelImages[index.row]!)
				modelImages.remove(at: index.row)
			}
		}
		
			cellsToBeDeleted = []
			CoreDataStack.sharedInstance?.save()
			collection.reloadData()
		
	}
	
	@objc func newCollection() {
		
		pageNumber += 1
		
		for image in modelImages {
			CoreDataStack.sharedInstance?.context.delete(image!)
		}
		
		modelImages.removeAll()
		images.removeAll()
		
		CoreDataStack.sharedInstance?.save()
		
		currentAnnotation.location.image = nil
		makeAPIRequest()
		DispatchQueue.main.async {
			self.collection.reloadData()
		}
		currentAnnotation.location.page = Int32(pageNumber)
	}
}
