//
//  DepthFirstSearch.swift
//  Graph Search Algorithms
//
//  Created by Robert Canton on 2015-11-19.
//  Copyright © 2015 Robert Canton. All rights reserved.
//
import SpriteKit

class DepthFirstSearch
{
    
    var endFound:Bool = false
    var numVisted:Int = 0
    var numNodes = 0
    
    func startSearch(node:cellNode, num:Int)
    {
        endFound = false
        numVisted = 0
        numNodes = num
        
        search(node)
    }
    
    func search (n:cellNode)
    {
        if (!endFound)
        {
            n.visited = true
            if (n.isGoal) {
                endFound = true
                numVisted = 0
            }
            else
            {
                numVisted++
                
                if (!n.isStart)
                {
                    let _hue:CGFloat = (CGFloat(numVisted) / CGFloat(numNodes)) * 0.3 + 0.6
                    n.colour(UIColor(hue: _hue, saturation: 0.5, brightness: 1, alpha: 1))
                    n.numberLabel.text = "\(numVisted-1)"
                    n.goalLabel.text = "\(n.goalDistance!)"
                    n.startLabel.text = "\(n.startDistance!)"
                    n.bothLabel.text = "\(n.goalDistance! + n.startDistance!)"
                }
                
                let n1 = UserSettings.getNextNode(n, num: 1)
                let n2 = UserSettings.getNextNode(n, num: 2)
                let n3 = UserSettings.getNextNode(n, num: 3)
                let n4 = UserSettings.getNextNode(n, num: 4)
                
                if n1 != nil && n1!.isVisitable() {
                    search(n1!)
                }
                if n2 != nil && n2!.isVisitable() {
                    search(n2!)
                }
                if n3 != nil && n3!.isVisitable() {
                    search(n3!)
                }
                if n4 != nil && n4!.isVisitable() {
                    search(n4!)
                }
                
            }
        }
    }
    
    
}