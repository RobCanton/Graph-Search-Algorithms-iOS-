//
//  Heap.swift
//  Graph Search Algorithms
//
//  Created by Robert Canton on 2015-11-22.
//  Copyright © 2015 Robert Canton. All rights reserved.
//


class Heap
{
    internal var heap:Array<cellNode?>
    
    private var size:Int = 0
    private var count:Int = 0
    
    
    init(size:Int)
    {
        count = 0
        self.size = size
        heap = [cellNode?](count: size + 1, repeatedValue: nil)
    }
    
    internal func peek() -> cellNode?
    {
        return heap[1]
    }
    
    internal func maxSize() -> Int
    {
        return size
    }
    
    internal func put(obj:cellNode) -> Bool
    {
        print("PUT - START")
        print(heap.capacity)
        if (count + 1 < heap.capacity)
        {
            count++
            print("PUT - Count: \(count) Cap: \(heap.capacity) Dist: \(heap[count]?.goalDistance)")
            
            heap[count] = obj
            
            var i:Int = count
            var parent:Int = i / 2
            let temp:cellNode = heap[i]!
            
            var v:cellNode;
            
            while(parent > 0)
            {
                print("PUT - 1")
                v = heap[parent]!
                if (temp.goalDistance! - v.goalDistance! < 0)
                {
                    heap[i] = v
                    i = parent
                    parent = parent / 2
                }
                else { break }
            }
            
            print("PUT - 2")
            heap[i] = temp
            return true
        }
        return false
    }
    
    internal func pop() -> cellNode?
    {
        
        if (count >= 1)
        {
            let o:cellNode = heap[1]!
            
            heap[1] = heap[count]!
            heap.removeAtIndex(count)
            
            var i:Int = 1
            var child:Int = i * 2
            var v:cellNode
            
            if let temp:cellNode = heap[i]
            {
             
                while (child < count)
                {
                    if (child < count - 1)
                    {
                        print("POP - 1")
                        if (heap[child]!.goalDistance! - heap[child+1]!.goalDistance! > 0)
                        {
                            child++
                        }
                    }
                    v = heap[child]!
                    if (temp.goalDistance! - v.goalDistance! < 0)
                    {
                        print("POP - 2")
                        heap[i] = v
                        i = child
                        child = child * 2
                    }
                    else { break }
                }
            }
            count--
            return o
        }
        return nil
    }
    
    internal func isEmpty() -> Bool
    {
        return count == 0
    
    }
    
    internal func printAll()
    {
        for i in 1...count {
            let x = heap[i]!.i
            let y = heap[i]!.j
            print("Size: \(size) Index: \(i) Count: \(count) | [\(x),\(y)] Dist: \(heap[i]!.goalDistance)")
        }
    }
    
    
}
