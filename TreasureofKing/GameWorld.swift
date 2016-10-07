//
//  GameWorld.swift
//  TreasureofKing
//
//  Created by Home on 8/6/16.
//  Copyright © 2016 Home. All rights reserved.
//

import Foundation
import SpriteKit
func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


func randomDouble() -> Double {
    return Double(arc4random()) / Double(UInt32.max)
}

class GameWorld : GameObjectNode, SKPhysicsContactDelegate{
    var size = CGSize()
    var treasures = GameObjectNode()
    var counter = 0
    var titleScreen = SKSpriteNode(imageNamed:"spr_title")
    var totalAction : SKAction? = nil
    var helpButton = Button(imageNamed: "spr_button_help")
    var helpframe = SKSpriteNode(imageNamed: "spr_help")
    var gameover = SKSpriteNode(imageNamed: "spr_gameover")
    var scoreLabel = Score()
    var sndGameOver = Sound("snd_gameover")
    var sndTreasureCollected = Sound("snd_treasure_collected")
    
    override init() {
        super.init();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup()
    {
        let background = SKSpriteNode(imageNamed: "spr_background")
        background.zPosition = 0
        self.addChild(background)
        
        let floor = SKNode()
        floor.position.y = -400
        var square = CGSize(width:GameScene.world.size.width, height: 200)
        floor.physicsBody = SKPhysicsBody(rectangleOf:  square)
        floor.physicsBody?.isDynamic = false
        addChild(floor)
        
        let ceiling = SKNode()
        ceiling.position.y = 800
        square = CGSize(width: GameScene.world.size.width, height: 200)
        ceiling.physicsBody = SKPhysicsBody(rectangleOf: square)
        ceiling.physicsBody?.isDynamic = false
        addChild(ceiling)
        
        let leftSideWall = SKNode()
        leftSideWall.position.x = -340
        square = CGSize(width: 100, height: GameScene.world.size.height)
        leftSideWall.physicsBody = SKPhysicsBody(rectangleOf: square)
        leftSideWall.physicsBody?.isDynamic = false
        addChild(leftSideWall)
        
        let rightSideWall = SKNode()
        rightSideWall.position.x = 340
        square = CGSize(width: 100, height: size.height)
        rightSideWall.physicsBody = SKPhysicsBody(rectangleOf: square)
        rightSideWall.physicsBody?.isDynamic = false
        addChild(rightSideWall)
        
        self.addChild(treasures)
        
        let dropTreasureAction = SKAction.run({
            let r: UInt32 = 5 + UInt32(self.counter)/10
            self.treasures.addChild(Treasure(range: r))
            self.counter += 1
        })
        
        let seq = SKAction.sequence([dropTreasureAction, SKAction.wait(forDuration: 2)])
         totalAction = SKAction.repeatForever(seq)
        
        let chimney = SKSpriteNode(imageNamed: "spr_chimney")
        chimney.zPosition = 10
        chimney.position.y = 510
        self.addChild(chimney)
        
        titleScreen.zPosition = Layer.Overlay2
        addChild(titleScreen)
        
        var helppos = topRight()
        helppos.x -= helpButton.sprite.size.width/2 + 10
        helppos.y -= helpButton.sprite.size.height/2 + 10
        helpButton.position = helppos
        helpButton.zPosition = 5
        addChild(helpButton)
        
        helpframe.zPosition = 20
        helpframe.isHidden = true
        addChild(helpframe)
        
        gameover.zPosition = Layer.Overlay2
        gameover.isHidden = true
        addChild(gameover)
        
        var scorePos = leftRight()
        scorePos.x += (scoreLabel.sprite.size.width/2 + 10)
        scorePos.y -= scoreLabel.sprite.size.height/2 + 10
        scoreLabel.position = scorePos
        addChild(scoreLabel)
    }
    
    func topRight() -> CGPoint {
        return CGPoint(x: size.width/2, y: size.height/2 - 20)
    }
    
    func leftRight() -> CGPoint {
        return CGPoint(x: -size.width/2, y: size.height/2 - 20)
    }
    
    
    override func handleInput(_ inputHelper : InputHelper)
    {
        
        if !titleScreen.isHidden {
            if inputHelper.hasTapped {
                titleScreen.isHidden = true
                self.run(self.totalAction!)
                return
            }
            
        }
        if !gameover.isHidden{
            if inputHelper.hasTapped{
                gameover.isHidden = true
                self.reset()
                self.run(self.totalAction!)
                return
            }
        }
        helpButton.handleInput(inputHelper)
        if(helpButton.tapped){
            if helpframe.isHidden{
                helpframe.isHidden = false
                self.removeAllActions()
            }
            else{
                helpframe.isHidden = true
                self.run(self.totalAction!)
            }
            
            return
        }

        super.handleInput(inputHelper)
        treasures.handleInput(inputHelper)
    }
    
    override func updateDelta(_ delta : TimeInterval){
        if titleScreen.isHidden && helpframe.isHidden && gameover.isHidden{
            super.updateDelta(delta)
            treasures.updateDelta(delta)
        }
    }
    
    override func reset() {
        super.reset()
        self.treasures.removeAllChildren()
        self.counter = 0
    }
    
    func isOutSizeWorld(_ pos : CGPoint) -> Bool{
        return (pos.x < -size.width/2 || pos.x > size.width/2 || pos.y < -size.height/2)
    }
    
    // physics handling
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA.node as? Treasure
        let secondBody = contact.bodyB.node as? Treasure
        
        if firstBody?.position.y > 400 && secondBody?.position.y > 400{
            sndGameOver.play()
            gameover.isHidden = false
            self.removeAllActions()
        }
        if firstBody == nil || secondBody == nil {
            return
        }
        
        if firstBody?.parent == nil || secondBody?.parent == nil {
            return
        }
        
        if firstBody?.type == TreasureType.Rock &&
            secondBody?.type == TreasureType.Rock {
            return
        }
  
        if firstBody?.type == secondBody?.type || firstBody?.type == TreasureType.Magic || secondBody?.type == TreasureType.Magic {
            firstBody?.removeFromParent()
            secondBody?.removeFromParent()
            scoreLabel.score += 1;
            sndTreasureCollected.play()
        }
    }
}
