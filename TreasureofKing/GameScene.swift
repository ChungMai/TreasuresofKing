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
    var delta : TimeInterval = 1/60
    
    override init(size: CGSize) {
        super.init(size: size)
        GameScene.world.size = size
        GameScene.world.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        anchorPoint = CGPoint(x:0.5, y: 0.5)
        view.frameInterval = 2
        delta = TimeInterval (view.frameInterval)/60
        self.addChild(GameScene.world)
        physicsWorld.contactDelegate = GameScene.world
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            touchmap[touch] = inputHelper.touchBegin(touch.location(in: self))
        }
    }
   
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchId = touchmap[touch]!
            inputHelper.touchMove(touchId, loc : touch.location(in: self))
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchId = touchmap[touch]!
            touchmap[touch] = nil
            inputHelper.touchEnd(touchId)
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        GameScene.world.handleInput(inputHelper)
        GameScene.world.updateDelta(delta)
        inputHelper.reset()
    }
}
