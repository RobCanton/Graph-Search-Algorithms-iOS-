//
//  cellNode.swift
//  Graph Search Algorithms
//
//  Created by Robert Canton on 2015-11-19.
//  Copyright © 2015 Robert Canton. All rights reserved.
//

import SpriteKit

class cellNode: SKShapeNode {
    
    var cell:SKShapeNode
    var i:Int
    var j:Int
    var visited = false
    var isWall  = false
    var isStart = false
    var isGoal  = false
    
    var top_node:cellNode?
    var rig_node:cellNode?
    var bot_node:cellNode?
    var lef_node:cellNode?
    
    
    init(name: String, pos: CGPoint, size: CGSize, i:Int, j:Int){
        
        cell = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        cell.strokeColor = UIColor.blackColor()
        cell.fillColor =   UIColor.whiteColor()
        cell.position = pos
        
        self.i = i
        self.j = j
        
        super.init()
        
        self.name = name
        addChild(cell)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func toStart ()
    {
        cell.fillColor = UIColor.blueColor()
        isStart = true
    }
    
    func toGoal ()
    {
        cell.fillColor = UIColor.redColor()
        isGoal = true
    }
    
    func toWall ()
    {
        cell.fillColor = UIColor.blackColor()
        isWall = true
    }

    
    func erase ()
    {
        cell.fillColor = UIColor.whiteColor()
        isStart = false
        isGoal =  false
        isWall =  false
    }
    
    func colour(color:UIColor)
    {
        cell.fillColor = color
    }
    
    
    func isVisitable() -> Bool {
        if (visited || isWall) {
            return false
        }
        return true
    }
    
    
}