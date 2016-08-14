//
//  Touch.swift
//  TreasureofKing
//
//  Created by Home on 8/6/16.
//  Copyright © 2016 Home. All rights reserved.
//

import Foundation
import SpriteKit

struct Touch {
    var id = 0
    var location = CGPoint()
    var tapped = true
    
    static var idgen : Int = 0
    
    init()
    {
        id = Touch.idgen;
        Touch.idgen = Touch.idgen + 1
    }
}