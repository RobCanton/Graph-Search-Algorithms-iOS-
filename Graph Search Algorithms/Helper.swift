//
//  Helper.swift
//  Project11
//
//  Created by Hudzilla on 22/11/2014.
//  Copyright (c) 2014 Hudzilla. All rights reserved.
//

import Foundation
import UIKit

func manhattanDistance(n1:cellNode, n2:cellNode) -> Int
{
    return abs(n1.i - n2.i) + abs(n1.j - n2.j)
}

func euclideanDistance(n1:cellNode, n2:cellNode) -> Int
{
    let deltaX = Double(abs(n1.i - n2.i))
    let deltaY = Double(abs(n1.j - n2.j))
    let ret = sqrt((deltaX * deltaX) * (deltaY * deltaY))
    return Int(ret)
}

func RandomInt(min min: Int, max: Int) -> Int {
	if max < min { return min }
	return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
}

func RandomFloat() -> Float {
	return Float(arc4random()) /  Float(UInt32.max)
}

func RandomFloat(min min: Float, max: Float) -> Float {
	return (Float(arc4random()) / Float(UInt32.max)) * (max - min) + min
}

func RandomDouble(min min: Double, max: Double) -> Double {
	return (Double(arc4random()) / Double(UInt32.max)) * (max - min) + min
}

func RandomCGFloat() -> CGFloat {
	return CGFloat(RandomFloat())
}

func RandomCGFloat(min min: Float, max: Float) -> CGFloat {
	return CGFloat(RandomFloat(min: min, max: max))
}

func RandomColor() -> UIColor {
	return UIColor(red: RandomCGFloat(), green: RandomCGFloat(), blue: RandomCGFloat(), alpha: 1)
}

func RunAfterDelay(delay: NSTimeInterval, block: dispatch_block_t) {
	let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
	dispatch_after(time, dispatch_get_main_queue(), block)
}