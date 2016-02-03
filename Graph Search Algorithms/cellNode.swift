//
//  cellNode.swift
//  Graph Search Algorithms
//
//  Created by Robert Canton on 2015-11-19.
//  Copyright © 2015 Robert Canton. All rights reserved.
//

import SpriteKit

class cellNode: SKSpriteNode {
    
    var cell:SKSpriteNode!
    var i:Int!
    var j:Int!
    var visited = false
    var isWall  = false
    var isStart = false
    var isGoal  = false
    
    var top_node:cellNode?
    var rig_node:cellNode?
    var bot_node:cellNode?
    var lef_node:cellNode?
    
    var goalDistance:Int?
    var startDistance:Int?
    
    var numberLabel = SKLabelNode(fontNamed: "Arial")
    var goalLabel = SKLabelNode(fontNamed: "Arial")
    var startLabel = SKLabelNode(fontNamed: "Arial")
    var bothLabel = SKLabelNode(fontNamed: "Arial")
    
    
    func create(name: String, pos: CGPoint, size: CGSize, i:Int, j:Int)
    {
        cell = SKSpriteNode(color: SKColor.whiteColor(), size: size)
        position = CGPoint(x: pos.x + size.width / 2, y: pos.y + size.height / 2)
        self.i = i
        self.j = j
        self.name = name
        self.addChild(cell)
        
        let fontSize = 8 + 8 * size.width / 100
        if UserSettings.showNumberLabel
        {
            numberLabel.fontSize = fontSize
            numberLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
            numberLabel.fontColor = numberLabelColor
            numberLabel.position = CGPointMake(-size.width/2 + fontSize / 5, size.height/2 - 10 - fontSize / 5)
            self.addChild(numberLabel)
        }
        
        if UserSettings.showGoalDistanceLabel
        {
            goalLabel.fontSize = fontSize
            goalLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
            goalLabel.fontColor = goalLabelColor
            goalLabel.position = CGPointMake(size.width/2 - fontSize / 5, size.height/2 - 10 - fontSize / 5)
            self.addChild(goalLabel)
        }
        if UserSettings.showStartDistanceLabel
        {
            startLabel.fontSize = fontSize
            startLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
            startLabel.fontColor = startLabelColor
            startLabel.position = CGPointMake(-size.width/2 + fontSize / 5, -size.height/2 + fontSize / 5)
            self.addChild(startLabel)
        }
        if UserSettings.showBothDistanceLabel
        {
            bothLabel.fontSize = fontSize
            bothLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
            bothLabel.fontColor = bothLabelColor
            bothLabel.position = CGPointMake(size.width/2 - fontSize / 5, -size.height/2 + fontSize / 5)
            self.addChild(bothLabel)
        }

    }
    
    
    func toStart ()
    {
        cell.color = UIColor.blueColor()
        isStart = true
        
        numberLabel.text = ""
        goalLabel.text = ""
        startLabel.text = ""
        bothLabel.text = ""
    }
    
    func toGoal ()
    {
        cell.color = UIColor.redColor()
        isGoal = true
        
        numberLabel.text = ""
        goalLabel.text = ""
        startLabel.text = ""
        bothLabel.text = ""
    }
    
    func toWall ()
    {
        cell.color = UIColor.blackColor()
        isWall = true
        
        numberLabel.text = ""
        goalLabel.text = ""
        startLabel.text = ""
        bothLabel.text = ""
    }

    
    func erase ()
    {
        cell.color = UIColor.whiteColor()
        isStart = false
        isGoal =  false
        isWall =  false
        
        numberLabel.text = ""
        goalLabel.text = ""
        startLabel.text = ""
        bothLabel.text = ""
    }
    
    func colour(color:UIColor)
    {
        cell.color = color
    }
    
    
    func isVisitable() -> Bool {
        if (visited || isWall) {
            return false
        }
        return true
    }
    
    
}