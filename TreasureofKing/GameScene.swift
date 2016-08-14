//
//  GameScene.swift
//  TreasureofKing
//
//  Created by Home on 8/6/16.
//  Copyright (c) 2016 Home. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var inputHelper = InputHelper()
    var touchmap = [UITouch : Int]()
    static var world = GameWorld()
    var delta : NSTimeInterval = 1/60
    
    override init(size: CGSize) {
        super.init(size: size)
        GameScene.world.size = size
        GameScene.world.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        anchorPoint = CGPoint(x:0.5, y: 0.5)
        view.frameInterval = 2
        delta = NSTimeInterval (view.frameInterval)/60
        self.addChild(GameScene.world)
        physicsWorld.contactDelegate = GameScene.world
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            touchmap[touch] = inputHelper.touchBegin(touch.locationInNode(self))
        }
    }
   
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let touchId = touchmap[touch]!
            inputHelper.touchMove(touchId, loc : touch.locationInNode(self))
        }
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let touchId = touchmap[touch]!
            touchmap[touch] = nil
            inputHelper.touchEnd(touchId)
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        GameScene.world.handleInput(inputHelper)
        GameScene.world.updateDelta(delta)
        inputHelper.reset()
    }
}
