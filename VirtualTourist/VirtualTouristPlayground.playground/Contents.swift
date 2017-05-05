//: Playground - noun: a place where people can play

var a: Int!
var b: Int! {
	didSet {
		if b > a && a > 1 {
			b = 1
		}
	}
}


a = 0
b = 4

print(b)
