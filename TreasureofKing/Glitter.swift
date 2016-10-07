//
//  Glitter.swift
//  TreasureofKing
//
//  Created by Home on 8/13/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class Glitter : GameObjectNode{
    var sprite = SKSpriteNode()
    override init(){
        super.init()
        sprite = SKSpriteNode(imageNamed: "spr_glitter")
        sprite.zPosition = Layer.Scene1
        self.xScale = 0
        self.yScale = 0
        addChild(sprite)
        let waitAction = SKAction.wait(forDuration: 0.1, withRange: 0.2)
        let scaleUpAction = SKAction.scale(to: 1, duration: 0.3)
        let scaleDownAction = SKAction.scale(to: 0, duration: 0.3)
        let totalAction = SKAction.sequence([waitAction,scaleUpAction,scaleDownAction])
        self.run(totalAction,completion: {
            self.removeFromParent()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
