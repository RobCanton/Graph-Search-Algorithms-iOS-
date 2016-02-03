//
//  BestFirstSearch.swift
//  Graph Search Algorithms
//
//  Created by Robert Canton on 2015-11-22.
//  Copyright © 2015 Robert Canton. All rights reserved.
//
import SpriteKit


class BestFirstSearch
{
    
    var endFound:Bool = false
    var numVisted:Int = 0
    var numNodes = 0
    
    var pq: PriorityQueue<BestFirstNode> = PriorityQueue<BestFirstNode>(ascending: true)
    
    func startSearch(node:cellNode, num:Int)
    {
        endFound = false
        numVisted = 0
        numNodes = num
        
        search(BestFirstNode(value: node))
    }
    
    private func search (n:BestFirstNode)
    {
        pq.clear()
        pq.push(n)
        
        while (!pq.isEmpty && !endFound && numVisted < numNodes)
        {
            
            if let pop:cellNode? = pq.pop()?.value
            {
         
                if (pop!.isGoal)
                {
                    endFound = true
                    numVisted = 0
                    pop!.visited = true
                }
                else if (pop!.isVisitable())
                {
                    numVisted++
                    pop!.visited = true
                    
                    if (!pop!.isStart)
                    {
                        let _hue:CGFloat = (CGFloat(numVisted) / CGFloat(numNodes)) * 0.4 + 0.55
                        pop!.colour(UIColor(hue: _hue, saturation: 0.5, brightness: 1, alpha: 1))
                        pop!.numberLabel.text = "\(numVisted-1)"
                        pop!.goalLabel.text = "\(pop!.goalDistance!)"
                        pop!.startLabel.text = "\(pop!.startDistance!)"
                        pop!.bothLabel.text = "\(pop!.goalDistance! + pop!.startDistance!)"
                    }
                    
                    let n1 = UserSettings.getNextNode(pop!, num: 1)
                    let n2 = UserSettings.getNextNode(pop!, num: 2)
                    let n3 = UserSettings.getNextNode(pop!, num: 3)
                    let n4 = UserSettings.getNextNode(pop!, num: 4)
                    
                    if n1 != nil && n1!.isVisitable() {
                        pq.push(BestFirstNode(value: n1))
                    }
                    
                    if n2 != nil && n2!.isVisitable() {
                        pq.push(BestFirstNode(value: n2))
                    }
                    
                    if n3 != nil && n3!.isVisitable() {
                        pq.push(BestFirstNode(value: n3))
                    }
                    
                    if n4 != nil && n4!.isVisitable() {
                        pq.push(BestFirstNode(value: n4))
                    }
                    
                }

            }
            
        }
        
    }
    
    
}