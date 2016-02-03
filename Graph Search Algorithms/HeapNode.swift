//
//  HeapNode.swift
//  Graph Search Algorithms
//
//  Created by Robert Canton on 2015-11-23.
//  Copyright © 2015 Robert Canton. All rights reserved.
//

class BestFirstNode:Comparable, Equatable
{
    var value:cellNode?

    
    init(value:cellNode?)
    {
        self.value = value

    }
    
}

func < (lhs: BestFirstNode, rhs: BestFirstNode) -> Bool
{
    return lhs.value?.goalDistance < rhs.value?.goalDistance
}

func == (lhs: BestFirstNode, rhs: BestFirstNode) -> Bool
{
    return lhs.value?.goalDistance == rhs.value?.goalDistance
}

class AStarNode:Comparable, Equatable
{
    var value:cellNode?
    
    
    init(value:cellNode?)
    {
        self.value = value
        
    }
    
}
func < (lhs: AStarNode, rhs: AStarNode) -> Bool
{
    let lhsSum = (lhs.value?.goalDistance)! + (lhs.value?.startDistance)!
    let rhsSum = (rhs.value?.goalDistance)! + (rhs.value?.startDistance)!
    return lhsSum < rhsSum
}

func == (lhs: AStarNode, rhs: AStarNode) -> Bool
{
    let lhsSum = (lhs.value?.goalDistance)! + (lhs.value?.startDistance)!
    let rhsSum = (rhs.value?.goalDistance)! + (rhs.value?.startDistance)!
    return lhsSum == rhsSum
}

