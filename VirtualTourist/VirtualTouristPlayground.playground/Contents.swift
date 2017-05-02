//: Playground - noun: a place where people can play

import Foundation
import UIKit
import CoreLocation

let a = 502
let b = 100 + a / 100


enum Things: Int {
	case Ab = 1
	case Cd = 100
	case Ef = 101
	case Gh = 102
}

Things(rawValue: 101)
Things.Ab.rawValue

let im = Things.Ab

switch im {
case .Ab: print("Ab")
default: print("def")
}

private var _lat: Double = 0
private var _lon: Double = 0

var t: (Double, Double) {
	set(point) {
		_lat = point.0
		_lon = point.1
	}
	get {
		return (_lat, _lon)
	}
}

var cl: CLLocationCoordinate2D {
	set (point) {
		_lat = cl.latitude
		_lon = cl.longitude
	}
	get {
		return CLLocationCoordinate2D(latitude: _lat, longitude: _lon)
	}
}

cl = CLLocationCoordinate2D(latitude: 12, longitude: 31)

print(_lat)

print(cl)

let url = URL(string: "https://farm3.staticflickr.com/2825/34016512540_a61706ab50.jpg")

var data: Data?
do {
	data = try Data(contentsOf: url!)
} catch {
	debugPrint(error)
}

let image = UIImage(data: data!)
let imageView = UIImageView(image: image)


