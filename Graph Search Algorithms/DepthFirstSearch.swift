//
//  DepthFirstSearch.swift
//  Graph Search Algorithms
//
//  Created by Robert Canton on 2015-11-19.
//  Copyright © 2015 Robert Canton. All rights reserved.
//
import SpriteKit
import Foundation

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
                print("Found end")
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
                }
                
                let n1 = n.top_node
                let n2 = n.rig_node
                let n3 = n.bot_node
                let n4 = n.lef_node
                
                if n1 != nil {
                    if n1!.isVisitable() {
                        search(n1!)
                    }
                }
                if n2 != nil {
                    if n2!.isVisitable() {
                        search(n2!)
                    }
                }
                if n3 != nil {
                    if n3!.isVisitable() {
                        search(n3!)
                    }
                }
                if n4 != nil {
                    if n4!.isVisitable() {
                        search(n4!)
                    }
                }
                
            }
        }
    }
    
    
}