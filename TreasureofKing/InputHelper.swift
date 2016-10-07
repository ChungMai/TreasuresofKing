//
//  InputHelper.swift
//  TreasureofKing
//
//  Created by Home on 8/6/16.
//  Copyright © 2016 Home. All rights reserved.
//

import Foundation
import SpriteKit

class InputHelper{
    
    var touches : [Touch] = []
    var nrTouches = 0
    var touchLocation = CGPoint.zero;
    
    func touchBegin(_ loc : CGPoint) -> Int
    {
        var  touch = Touch()
        touch.location = loc
        touches.append(touch)
        return touch.id
    }
    
    func touchMove(_ id : Int, loc : CGPoint){
        if let index = findIndex(id){
            touches[index].location = loc
        }
    }
    
    func touchEnd(_ id : Int)
    {
        if let index = findIndex(id)
        {
            touches.remove(at: index)
        }
    }
    
    func findIndex(_ id: Int) -> Int?
    {
        for index in 0..<touches.count{
            if id == touches[index].id{
                return index
            }
        }
        return nil
    }
    
    func getTouch(_ id : Int) -> CGPoint {
        if let index = findIndex(id){
            return touches[index].location
        }
        return CGPoint.zero
    }
    
    func containTouch(_ rect : CGRect) -> Bool{
        for touch in touches{
            if(rect.contains(touch.location)){
                return true
            }
        }
        
        return false
    }
    
    func getIdInRect(_ rect : CGRect) -> Int? {
        for touch in touches{
            if(rect.contains(touch.location)){
                return touch.id
            }
        }
        
        return nil
    }
    
    func isTouching(_ id : Int) -> Bool {
        return findIndex(id) != nil
    }
    
    func containsTap(_ rect : CGRect) -> Bool{
        for touch in touches{
            if rect.contains(touch.location) && touch.tapped{
                return true
            }
        }
        
        return false
    }
    
    func reset() {
        for index in 0..<touches.count  {
            touches[index].tapped = false
        }
    }
    
    var hasTapped: Bool {
        get {
            for touch in touches {
                if touch.tapped {
                    return true
                }
            }
            return false
        }
    }
}
