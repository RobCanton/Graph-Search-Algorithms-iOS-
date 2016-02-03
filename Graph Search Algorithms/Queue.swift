//
//  Queue.swift
//  Graph Search Algorithms
//
//  Created by Robert Canton on 2015-11-22.
//  Copyright © 2015 Robert Canton. All rights reserved.
//


class Queue
{
    private var first:DataNode?
    private var last:DataNode?
    private var N:Int = 0
    
    internal func size() -> Int
    {
        return N
    }
    
    internal func isEmpty() -> Bool
    {
        return first == nil
    }
    
    internal func peek() -> AnyObject?
    {
        if (isEmpty())
        {
            print("Queue underflow")
            return nil
        }
        return (first?.value)!
    }
    
    internal func enqueue(obj:AnyObject)
    {
        let newNode:DataNode = DataNode(value: obj)
        if (isEmpty())
        {
            print("First Enqueue")
            first = newNode
            last = newNode
        }
        else
        {
            print("Enqueue")
            last?.next = newNode
            last = newNode
        }
        N++
    }
    
    internal func dequeue() -> AnyObject?
    {
        var returnNode:AnyObject?
        
        if (!isEmpty())
        {
            print("Dequeue not empty")
            returnNode = (first?.value)!
            first = first?.next
            N--
        }
        else
        {
            last = nil
            print("Queue underflow")
            return nil
        }
        
        return returnNode
    }
    
    
    
    
}
