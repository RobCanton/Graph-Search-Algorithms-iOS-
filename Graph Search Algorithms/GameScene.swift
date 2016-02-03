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

class GameScene: SKScene, GridProtocol {
    
    var cellSize:CGFloat = CGFloat(UserSettings.cellSize())
    var numRows:Int =  0
    var numCols:Int =  10
    var startBtn:cellButton = cellButton()
    var goalBtn:cellButton = cellButton()
    var wallBtn:cellButton = cellButton()
    var eraseBtn:cellButton = cellButton()
    
    var startNode:cellNode?
    var goalNode:cellNode?
    var nodes:Array2D?
    
    var curType:type = type.Start
    
    var searchType:search = search.DepthFirst
    let d:DepthFirstSearch = DepthFirstSearch()
    let b:BreadthFirstSearch = BreadthFirstSearch()
    let bf:BestFirstSearch = BestFirstSearch()
    let a:AStarSearch = AStarSearch()
    
    var buttonHeight:CGFloat = 96
    
    override func didMoveToView(view: SKView) {
        
        createGrid()
        
        let buttonWidth = self.size.width / 4
        startBtn.makeButton("startBtn", pos: CGPoint(x:0, y:0), size: CGSize(width: buttonWidth, height: buttonHeight),
            colour: UIColor.blueColor())
        goalBtn.makeButton("goalBtn", pos: CGPoint(x: buttonWidth, y:0), size: CGSize(width: buttonWidth, height: buttonHeight),
            colour: UIColor.redColor())
        wallBtn.makeButton("wallBtn", pos: CGPoint(x:buttonWidth * 2, y:0), size: CGSize(width: buttonWidth, height: buttonHeight),
            colour: UIColor.blackColor())
        eraseBtn.makeButton("eraseBtn", pos: CGPoint(x:buttonWidth * 3, y:0), size: CGSize(width: buttonWidth, height: buttonHeight),
            colour: UIColor.whiteColor())
        
        addChild(startBtn)
        addChild(goalBtn)
        addChild(wallBtn)
        addChild(eraseBtn)
        
        startBtn.activate()

        
    }
    
    func refresh() {
        print("Refresh")
        startNode = nil
        goalNode = nil
        deleteGrid()
        createGrid()
        
    }
    
    func createGrid()
    {
        print("Create Grid")
        
        let gridHeight = self.frame.height - (buttonHeight+44);
        cellSize = CGFloat(UserSettings.cellSize())
        numCols = Int( self.frame.width / cellSize)
        numRows = Int( gridHeight / cellSize)
        
        nodes = Array2D(cols: numRows+1, rows: numCols+1)
        
        initGrid()
        
        setNodePointers()
    }
    
    func setSearchType(type:String)
    {
        switch type {
            case "Depth First Search":
                searchType = search.DepthFirst
                break
            case "Breadth First Search":
                searchType = search.BreadthFirst
                break
            case "Best First Search":
                searchType = search.BestFirst
                break
            case "A Star Search":
                searchType = search.AStar
                break
            default:
                break
        }
        doSearch()
    }
    
    func initGrid() {
        let bar:CGFloat = buttonHeight
        // Bot Left
        let widthCheck = self.frame.width - cellSize * CGFloat(numCols)
        var xShift:CGFloat = 0
        if widthCheck > 0
        {
            xShift = widthCheck / 2
        }
        var point = CGPoint(x:CGFloat(0) * cellSize + xShift, y: bar + CGFloat(0) * cellSize)
        var cell = cellNode()
        cell.create("botLeft", pos: point,size: CGSize(width: cellSize, height:cellSize),i: 0, j: 0)
        nodes![0,0] = cell
        
        // Bot Right
        point = CGPoint(x:CGFloat(numCols - 1) * cellSize + xShift, y: bar + CGFloat(0) * cellSize)
        cell = cellNode()
        cell.create("botRight", pos: point,size: CGSize(width: cellSize, height:cellSize),i: 0, j: numCols-1)
        nodes![0,numCols-1] = cell
        
        // Top Left
        point = CGPoint(x:CGFloat(0) * cellSize + xShift, y: bar + CGFloat(numRows) * cellSize)
        cell = cellNode()
        cell.create("topLeft", pos: point,size: CGSize(width: cellSize, height:cellSize),i: numRows, j: 0)
        nodes![numRows,0] = cell
        
        // Top Right
        point = CGPoint(x:CGFloat(numCols - 1) * cellSize + xShift, y: bar + CGFloat(numRows) * cellSize)
        cell = cellNode()
        cell.create("topRight", pos: point,size: CGSize(width: cellSize, height:cellSize),i: numRows, j: numCols-1)
        nodes![numRows,numCols-1] = cell
        
        
        // Bot Row
        for j in 1...numCols-2 {
            point = CGPoint(x:CGFloat(j) * cellSize + xShift, y: bar + CGFloat(0) * cellSize)
            cell = cellNode()
            cell.create("botRow", pos: point,size: CGSize(width: cellSize, height:cellSize),i: 0, j: j)
            nodes![0,j] = cell
        }
        
        // Top Row
        for j in 1...numCols-2 {
            point = CGPoint(x:CGFloat(j) * cellSize + xShift, y: bar + CGFloat(numRows) * cellSize)
            cell = cellNode()
            cell.create("topRow", pos: point,size: CGSize(width: cellSize, height:cellSize),i: numRows, j: j)
            nodes![numRows,j] = cell
        }
        
        // Left Col
        for i in 1...numRows-1 {
            point = CGPoint(x:CGFloat(0) * cellSize + xShift, y: bar + CGFloat(i) * cellSize)
            cell = cellNode()
            cell.create("leftCol", pos: point,size: CGSize(width: cellSize, height:cellSize),i: i, j: 0)
            nodes![i,0] = cell
        }
        
        // Right Col
        for i in 1...numRows-1 {
            point = CGPoint(x:CGFloat(numCols - 1) * cellSize + xShift, y: bar + CGFloat(i) * cellSize)
            cell = cellNode()
            cell.create("rightCol", pos: point,size: CGSize(width: cellSize, height:cellSize),i: i, j: numCols-1)
            nodes![i,numCols-1] = cell
        }
        
        for j in 1...numCols-2 {
            for i in 1...numRows-1 {
                let point = CGPoint(x:CGFloat(j) * cellSize + xShift, y: bar + CGFloat(i) * cellSize)
                cell = cellNode()
                cell.create("middle", pos: point,size: CGSize(width: cellSize, height:cellSize),i: i, j: j)
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
    
    func nodeTouched(touchPoint:CGPoint)
    {
        let nodes = nodesAtPoint(touchPoint)
        
        for node in nodes {
            if node.isKindOfClass(cellNode) {
                let cell = node as! cellNode
                var bool_search = true
                if curType == .Start {
                    if (!cell.isGoal && !cell.isWall)
                    {
                        startNode?.erase()
                        startNode = cell;
                        startNode?.toStart()
                    }
                }
                else if curType == .Goal {
                    if (!cell.isStart && !cell.isWall)
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
                        if (!cell.visited)
                        {
                            bool_search = false
                        }
                    }
                }
                    
                else if curType == .Erase {
                    if (!cell.isStart && !cell.isGoal)
                    {
                        cell.erase()
                    }
                }
                
                if (bool_search)
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

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            nodeTouched(location)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            nodeTouched(location)
        }
    }
    
    func doSearch()
    {
        if (startNode != nil && goalNode != nil)
        {
            
            eraseGrid()
            calcAllDistances()
            switch searchType {
                case search.DepthFirst:
                    d.startSearch(startNode!, num: (numRows * (numCols - 1)))
                    d.search(startNode!)
                    break
                case search.BreadthFirst:
                    b.startSearch(startNode!, num: (numRows * (numCols - 1)))
                    break
                case search.BestFirst:
                    bf.startSearch(startNode!, num: (numRows * (numCols - 1)))
                    break
                case search.AStar:
                    a.startSearch(startNode!, num: (numRows * (numCols - 1)))
                    break
                default:
                    break
            }
        }
        
    }
    
    func eraseGrid()
    {
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
    
    func deleteGrid()
    {
        for i in 0...numRows {
            for j in 0...numCols-1 {
                let node = nodes![i,j] as! cellNode
                node.removeFromParent()
            }
        }
    }
    
    func calcAllDistances()
    {
        for i in 0...numRows {
            for j in 0...numCols-1 {
                let node = nodes![i,j] as! cellNode
                if UserSettings.measurementType == 0
                {
                    node.goalDistance = manhattanDistance(node, n2: goalNode!)
                    node.startDistance = manhattanDistance(node, n2: startNode!)
                }
                else
                {
                    node.goalDistance = euclideanDistance(node, n2: goalNode!)
                    node.startDistance = euclideanDistance(node, n2: startNode!)
                }
            }
        }

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    

}

protocol GridProtocol {
    func refresh()
}
