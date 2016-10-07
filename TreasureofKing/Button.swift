//
//  Button.swift
//  TreasureofKing
//
//  Created by Home on 8/11/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class Button : GameObjectNode{
    
    var tapped = false
    var sprite  = SKSpriteNode()
    override func handleInput(_ inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        tapped = inputHelper.containsTap(self.box)
    }
    
    init(imageNamed:String){
        super.init()
        sprite = SKSpriteNode(imageNamed: imageNamed)
        addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
