//
//  Score.swift
//  TreasureofKing
//
//  Created by Home on 8/13/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class Score : GameObjectNode{
    
    var sprite = SKSpriteNode(imageNamed: "spr_scorebar")
    var label = SKLabelNode()
    private var scoreValue = 0
    
    
    override init(){
        super.init()
        sprite.zPosition = Layer.Overlay
        self.addChild(sprite)
        
        label.fontName = "CheapPotatoes"
        label.position = CGPoint(x: 50, y : 0)
        label.zPosition = Layer.Overlay1
        label.fontColor = UIColor.blackColor()
        label.fontSize = 20
        label.verticalAlignmentMode = .Center
        label.horizontalAlignmentMode = .Right
        label.text = "0"
        self.addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var score: Int {
        get {
            return scoreValue
        }
        set {
            scoreValue = newValue
            label.text = String(self.scoreValue)
        }
    }
}
