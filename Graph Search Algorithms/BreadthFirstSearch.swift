//
//  DepthFirstSearch.swift
//  Graph Search Algorithms
//
//  Created by Robert Canton on 2015-11-19.
//  Copyright © 2015 Robert Canton. All rights reserved.
//
import SpriteKit

class BreadthFirstSearch
{
    
    var endFound:Bool = false
    var numVisted:Int = 0
    var numNodes = 0
    
    var Q:Queue = Queue()
    
    func startSearch(node:cellNode, num:Int)
    {
        endFound = false
        numVisted = 0
        numNodes = num
        search(node)
    }
    
    private func search (n:cellNode)
    {
        Q = Queue()
        Q.enqueue(n)
        
        while (!Q.isEmpty() && !endFound)
        {
            print(Q.size())
            let temp:cellNode = Q.dequeue() as! cellNode

            if (temp.isGoal)
            {
                endFound = true
                numVisted = 0
                temp.visited = true
            }
            
            else if (temp.isVisitable())
            {
                numVisted++
                temp.visited = true
                
                if (!temp.isStart)
                {
                    let _hue:CGFloat = (CGFloat(numVisted) / CGFloat(numNodes)) * 0.3 + 0.6
                    temp.colour(UIColor(hue: _hue, saturation: 0.5, brightness: 1, alpha: 1))
                    temp.numberLabel.text = "\(numVisted-1)"
                    temp.goalLabel.text = "\(temp.goalDistance!)"
                    temp.startLabel.text = "\(temp.startDistance!)"
                    temp.bothLabel.text = "\(temp.goalDistance! + temp.startDistance!)"
                }
                
                let n1 = UserSettings.getNextNode(temp, num: 1)
                let n2 = UserSettings.getNextNode(temp, num: 2)
                let n3 = UserSettings.getNextNode(temp, num: 3)
                let n4 = UserSettings.getNextNode(temp, num: 4)
                
                if n1 != nil && n1!.isVisitable() {
                    Q.enqueue(n1!)
                }
                if n2 != nil && n2!.isVisitable() {
                    Q.enqueue(n2!)
                }
                if n3 != nil && n3!.isVisitable() {
                    Q.enqueue(n3!)
                }
                if n4 != nil && n4!.isVisitable() {
                    Q.enqueue(n4!)
                }
            }
        }
        
    }
    
    
}