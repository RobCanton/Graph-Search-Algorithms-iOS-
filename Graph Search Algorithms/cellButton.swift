//
//  cellNode.swift
//  Graph Search Algorithms
//
//  Created by Robert Canton on 2015-11-19.
//  Copyright © 2015 Robert Canton. All rights reserved.
//

import SpriteKit

class cellButton: SKShapeNode {
    
    func makeButton(name: String, pos: CGPoint, size: CGSize, colour: UIColor){
        
        let button = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        button.strokeColor = UIColor.blackColor()
        button.fillColor =   colour
        button.position = pos
        
        self.name = name
        addChild(button)
        self.alpha = 0.4
    }
    
    func activate()
    {
        self.alpha = 1
        
    }
    
    func deactivate()
    {
        self.alpha = 0.4
    }
    
    
    

    
    
}