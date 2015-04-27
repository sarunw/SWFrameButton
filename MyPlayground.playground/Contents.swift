//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let size = CGSize(width: 100, height: 100)
let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
UIGraphicsBeginImageContextWithOptions(size, false, 0)
let context = UIGraphicsGetCurrentContext()
let path = UIBezierPath(roundedRect: rect, cornerRadius: 10)
CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
path.fill()
let image = UIGraphicsGetImageFromCurrentImageContext()
