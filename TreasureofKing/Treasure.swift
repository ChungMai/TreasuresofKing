//
//  Treasure.swift
//  TreasureofKing
//
//  Created by Home on 8/6/16.
//  Copyright © 2016 Home. All rights reserved.
//

import Foundation
import SpriteKit

class Treasure : GameObjectNode{
    var sprite = SKSpriteNode()
    var touchId : Int? = nil;
    var type : UInt32  = 0
    var action : SKAction? = nil
    
    init(type:UInt32) {
        super.init()
        self.type = type
        if(type == TreasureType.Rock){
            sprite = SKSpriteNode(imageNamed: "spr_rock")
        }
        else if arc4random_uniform(6) == 0{
            sprite = SKSpriteNode(imageNamed: "spr_magic")
            self.type = TreasureType.Magic
            
            let addGlitterAction = SKAction.runBlock({
                self.addGlitter()
            })
            
            let waitAction = SKAction.waitForDuration(0.1)
            let totalAction = SKAction.repeatActionForever(SKAction.sequence([addGlitterAction, waitAction]))
            self.runAction(totalAction)
            
        }
        else{
            action = SKAction.waitForDuration(20)
            sprite = SKSpriteNode(imageNamed: "spr_treasure_\(type)")
            self.runAction(action!, completion:{
                let rock = Treasure(type:TreasureType.Rock)
                rock.position = self.position
                self.parent?.addChild(rock)
                self.removeFromParent()
            })
        }
        
        sprite.zPosition = 1
        self.position.y = 500
        self.addChild(sprite)
        self.physicsBody = SKPhysicsBody(texture:sprite.texture!, size: sprite.size)
        self.physicsBody?.contactTestBitMask = 1
    }
    
    convenience init(range : UInt32) {
        let finalRange = min(range,20)
        let tp = arc4random_uniform(finalRange)
        self.init(type:tp)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func handleInput(inputHelper : InputHelper)
    {
        if position.y > 200{
            touchId = nil
            if physicsBody?.velocity.dy > 0{
                physicsBody?.velocity = CGVector.zero
            }
        }
        
        if inputHelper.containsTap(self.box)
        {
            touchId = inputHelper.getIdInRect(self.box)
        }
        
        if touchId != nil{
            if inputHelper.isTouching(touchId!){
                self.position = inputHelper.getTouch(touchId!)
            }
            else{
                touchId = nil
            }
        }
    }
    
    func addGlitter() {
        let glitter = Glitter()
        let radius = randomDouble() * 70
        let angle = randomDouble() * 2 * M_PI
        glitter.position.x += CGFloat(cos(angle) * radius)
        glitter.position.y += CGFloat(sin(angle) * radius)
        self.addChild(glitter)
    }
}
