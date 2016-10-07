//
//  GameViewController.swift
//  TreasureofKing
//
//  Created by Home on 8/6/16.
//  Copyright (c) 2016 Home. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let skView = self.view as! SKView
        skView.isMultipleTouchEnabled = true
        skView.ignoresSiblingOrder = true
        var viewSize = skView.bounds.size
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            viewSize.height *= 2
            viewSize.width *= 2
        }
        
        let scence = GameScene(size : viewSize)
        scence.scaleMode = .aspectFill
        skView.presentScene(scence)
    }
}
