//
//  GameObjectNode.swift
//  TreasureofKing
//
//  Created by Home on 8/7/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class GameObjectNode : SKNode{
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func handleInput(inputHelper: InputHelper) {
        for obj in children {
            if let node = obj as? GameObjectNode {
                node.handleInput(inputHelper)
            }
        }
    }
    
    func updateDelta(delta: NSTimeInterval) {
        for obj in children {
            if let node = obj as? GameObjectNode {
                node.updateDelta(delta)
            }
        }
    }
    
    func reset() {
        for obj in children {
            if let node = obj as? GameObjectNode {
                node.reset()
            }
        }
    }
    
    var box : CGRect{
        get{
            return self.calculateAccumulatedFrame()
        }
    }
    
    
}
