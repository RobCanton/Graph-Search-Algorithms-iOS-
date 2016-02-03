//
//  UserSettings.swift
//  Graph Search Algorithms
//
//  Created by Robert Canton on 2016-02-02.
//  Copyright © 2016 Robert Canton. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let numberLabelColor = UIColor.yellowColor()
let goalLabelColor = UIColor(red: 1.0, green: 200/255, blue: 200/255, alpha: 1.0)
let startLabelColor = UIColor(red: 0.6, green: 228/255, blue: 1.0, alpha: 1.0)
let bothLabelColor = UIColor.greenColor()

enum Direction {
    case Top
    case Right
    case Bottom
    case Left
}


class UserSettings
{
    static var cellSizeDecimal = 0.5
    static var showNumberLabel = true
    static var showGoalDistanceLabel = false
    static var showStartDistanceLabel = false
    static var showBothDistanceLabel = false
    static var measurementType = 0
    
    static var order = [Direction.Top, Direction.Right, Direction.Bottom, Direction.Left]
    
    static func cellSize() -> Double
    {
        return 30 + 70 * cellSizeDecimal
    }
    
    static func getNextNode(n:cellNode, num:Int) -> cellNode?
    {
        let direction:Direction = order[num-1]
        var node:cellNode?
        switch direction
        {
            case .Top:
                node = n.top_node
                break
            case .Right:
                node = n.rig_node
                break
            case .Bottom:
                node = n.bot_node
                break
            case .Left:
                node = n.lef_node
                break
        }
        return node
    }

    

}