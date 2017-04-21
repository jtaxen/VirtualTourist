//: Playground - noun: a place where people can play

import UIKit

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