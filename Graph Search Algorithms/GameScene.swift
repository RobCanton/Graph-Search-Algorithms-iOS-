//
//  GameScene.swift
//  Graph Search Algorithms
//
//  Created by Robert Canton on 2015-11-19.
//  Copyright (c) 2015 Robert Canton. All rights reserved.
//

import SpriteKit
import Foundation

enum type {
    case Start, Goal, Wall, Erase
}

enum search {
    case DepthFirst, BreadthFirst, BestFirst, AStar
}

class GameScene: SKScene {
    
    var cellSize:CGFloat = 50
    var numRows:Int =  0
    var numCols:Int =  10
    var startBtn:cellButton = cellButton()
    var goalBtn:cellButton = cellButton()
    var wallBtn:cellButton = cellButton()
    var eraseBtn:cellButton = cellButton()
    
    var startNode:cellNode?
    var goalNode:cellNode?
    let d:DepthFirstSearch = DepthFirstSearch()
    var nodes:Array2D?
    
    
    var curType:type = type.Start
    
    
    override func didMoveToView(view: SKView) {
        print("Width")
        print(self.size.width)
        print("Height")
        print(self.size.height)
        
        let gridHeight = self.frame.height - (88+44);
        cellSize = (self.frame.width / CGFloat(numCols))
        numRows = Int( gridHeight / cellSize)
        print("Num Rows")
        print(numRows)
        print("Num Cells")
        print(numCols)
        
        nodes = Array2D(cols: numRows+1, rows: numCols+1)
        
        initGrid()
        setNodePointers()
        let buttonWidth = self.size.width / 4
        startBtn.makeButton("startBtn", pos: CGPoint(x:0, y:0), size: CGSize(width: buttonWidth, height: 88),
            colour: UIColor.blueColor())
        goalBtn.makeButton("goalBtn", pos: CGPoint(x: buttonWidth, y:0), size: CGSize(width: buttonWidth, height: 88),
            colour: UIColor.redColor())
        wallBtn.makeButton("wallBtn", pos: CGPoint(x:buttonWidth * 2, y:0), size: CGSize(width: buttonWidth, height: 88),
            colour: UIColor.blackColor())
        eraseBtn.makeButton("eraseBtn", pos: CGPoint(x:buttonWidth * 3, y:0), size: CGSize(width: buttonWidth, height: 88),
            colour: UIColor.whiteColor())
        
        addChild(startBtn)
        addChild(goalBtn)
        addChild(wallBtn)
        addChild(eraseBtn)
        
        startBtn.activate()
        
        
    }
    
    func setSearchType(type:String)
    {
        print(type)
    }
    
    func initGrid() {
        let bar:CGFloat = 88
        // Bot Left
        var point = CGPoint(x:CGFloat(0) * cellSize, y: bar + CGFloat(0) * cellSize)
        var cell = cellNode(name: "botLeft", pos: point,size: CGSize(width: cellSize, height:cellSize),i: 0, j: 0)
        nodes![0,0] = cell
        
        // Bot Right
        point = CGPoint(x:CGFloat(numCols - 1) * cellSize, y: bar + CGFloat(0) * cellSize)
        cell = cellNode(name: "botRight", pos: point,size: CGSize(width: cellSize, height:cellSize),i: 0, j: numCols-1)
        nodes![0,numCols-1] = cell
        
        // Top Left
        point = CGPoint(x:CGFloat(0) * cellSize, y: bar + CGFloat(numRows) * cellSize)
        cell = cellNode(name: "topLeft", pos: point,size: CGSize(width: cellSize, height:cellSize),i: numRows, j: 0)
        nodes![numRows,0] = cell
        
        // Top Right
        point = CGPoint(x:CGFloat(numCols - 1) * cellSize, y: bar + CGFloat(numRows) * cellSize)
        cell = cellNode(name: "topRight", pos: point,size: CGSize(width: cellSize, height:cellSize),i: numRows, j: numCols-1)
        nodes![numRows,numCols-1] = cell
        
        
        // Bot Row
        for j in 1...numCols-2 {
            point = CGPoint(x:CGFloat(j) * cellSize, y: bar + CGFloat(0) * cellSize)
            cell = cellNode(name: "botRow", pos: point,size: CGSize(width: cellSize, height:cellSize),i: 0, j: j)
            nodes![0,j] = cell
        }
        
        // Top Row
        for j in 1...numCols-2 {
            point = CGPoint(x:CGFloat(j) * cellSize, y: bar + CGFloat(numRows) * cellSize)
            cell = cellNode(name: "topRow", pos: point,size: CGSize(width: cellSize, height:cellSize),i: numRows, j: j)
            nodes![numRows,j] = cell
        }
        
        // Left Col
        for i in 1...numRows-1 {
            point = CGPoint(x:CGFloat(0) * cellSize, y: bar + CGFloat(i) * cellSize)
            cell = cellNode(name: "leftCol", pos: point,size: CGSize(width: cellSize, height:cellSize),i: i, j: 0)
            nodes![i,0] = cell
        }
        
        // Right Col
        for i in 1...numRows-1 {
            point = CGPoint(x:CGFloat(numCols - 1) * cellSize, y: bar + CGFloat(i) * cellSize)
            cell = cellNode(name: "rightCol", pos: point,size: CGSize(width: cellSize, height:cellSize),i: i, j: numCols-1)
            nodes![i,numCols-1] = cell
        }
        
        for j in 1...numCols-2 {
            for i in 1...numRows-1 {
                let point = CGPoint(x:CGFloat(j) * cellSize, y: bar + CGFloat(i) * cellSize)
                let cell = cellNode(name: "middle", pos: point,size: CGSize(width: cellSize, height:cellSize),i: i, j: j)
                nodes![i,j] = cell
            }
        }
    }
    
    func setNodePointers()     {
        for i in 0...numRows {
            for j in 0...numCols {
                if let cell = nodes![i,j] as? cellNode
                {
                    addChild(cell)
                    print(cell.name);
                    
                    switch cell.name! {
                        case "botLeft":
                            cell.top_node = nodes![i+1,j] as? cellNode
                            cell.rig_node = nodes![i,j+1] as? cellNode
                            break
                        case "botRight":
                            cell.top_node = nodes![i+1,j] as? cellNode
                            cell.lef_node = nodes![i,j-1] as? cellNode
                            break
                        case "topLeft":
                            cell.bot_node = nodes![i-1,j] as? cellNode
                            cell.rig_node = nodes![i,j+1] as? cellNode
                            break
                        case "topRight":
                            cell.bot_node = nodes![i-1,j] as? cellNode
                            cell.lef_node = nodes![i,j-1] as? cellNode
                            break
                        case "leftCol":
                            cell.top_node = nodes![i+1,j] as? cellNode
                            cell.rig_node = nodes![i,j+1] as? cellNode
                            cell.bot_node = nodes![i-1,j] as? cellNode
                            break
                        case "rightCol":
                            cell.top_node = nodes![i+1,j] as? cellNode
                            cell.lef_node = nodes![i,j-1] as? cellNode
                            cell.bot_node = nodes![i-1,j] as? cellNode
                            break
                        case "topRow":
                            cell.rig_node = nodes![i,j+1] as? cellNode
                            cell.lef_node = nodes![i,j-1] as? cellNode
                            cell.bot_node = nodes![i-1,j] as? cellNode
                            break
                        case "botRow":
                            cell.rig_node = nodes![i,j+1] as? cellNode
                            cell.lef_node = nodes![i,j-1] as? cellNode
                            cell.top_node = nodes![i+1,j] as? cellNode
                            break
                        case "middle":
                            cell.rig_node = nodes![i,j+1] as? cellNode
                            cell.lef_node = nodes![i,j-1] as? cellNode
                            cell.top_node = nodes![i+1,j] as? cellNode
                            cell.bot_node = nodes![i-1,j] as? cellNode
                            break
                        default:
                            break
                    }
                }
            }
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            let nodes = nodesAtPoint(location)
            
            for node in nodes {
                if node.isKindOfClass(cellNode) {
                    let cell = node as! cellNode
                    if curType == .Start {
                        if (!cell.isGoal)
                        {
                            startNode?.erase()
                            startNode = cell;
                            startNode?.toStart()
                        }
                    }
                    else if curType == .Goal {
                        if (!cell.isStart)
                        {
                            goalNode?.erase()
                            goalNode = cell;
                            goalNode?.toGoal()
                        }
                    }
                    
                    else if curType == .Wall {
                        if (!cell.isStart && !cell.isGoal)
                        {
                            cell.toWall()
                        }
                    }
                    
                    else if curType == .Erase {
                        cell.erase()
                    }
                    
                    if (startNode != nil && goalNode != nil)
                    {
                        
                        doSearch()
                    }

                }
                if node.isKindOfClass(cellButton)
                {
                    if node.name == "startBtn" {
                        let btn = node as! cellButton
                        curType = .Start
                        btn.activate()
                        goalBtn.deactivate()
                        wallBtn.deactivate()
                        eraseBtn.deactivate()
                    }
                    else if node.name == "goalBtn" {
                        let btn = node as! cellButton
                        curType = .Goal
                        btn.activate()
                        startBtn.deactivate()
                        wallBtn.deactivate()
                        eraseBtn.deactivate()
                    }
                    else if node.name == "wallBtn" {
                        let btn = node as! cellButton
                        curType = .Wall
                        btn.activate()
                        goalBtn.deactivate()
                        startBtn.deactivate()
                        eraseBtn.deactivate()
                    }
                    else if node.name == "eraseBtn" {
                        let btn = node as! cellButton
                        curType = .Erase
                        btn.activate()
                        goalBtn.deactivate()
                        wallBtn.deactivate()
                        startBtn.deactivate()
                    }
                }
            }
        }
    }
    
    func doSearch()
    {
        print("Do search")
        eraseGrid()
        d.startSearch(startNode!, num: (numRows * (numCols - 1)))
        d.search(startNode!)
    }
    
    func eraseGrid()
    {
        print("Erasing")
        for i in 0...numRows {
            for j in 0...numCols-1 {
                let node = nodes![i,j] as! cellNode
                node.visited = false
                if (!node.isStart && !node.isGoal && !node.isWall)
                {
                    node.erase()
                }
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    


}
