//
//  Sound.swift
//  TreasureofKing
//
//  Created by Home on 8/14/16.
//  Copyright © 2016 Home. All rights reserved.
//

import AVFoundation

class Sound{
    var audioPlayer : AVAudioPlayer?
    
    init(_ fileNamed : String){
        let soundURL = NSBundle.mainBundle().URLForResource(fileNamed, withExtension: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOfURL: soundURL!)
    }
    
    var volum : Float{
        get{
            if audioPlayer != nil{
                return audioPlayer!.volume
            }
            else{
                return 0
            }
        }
        
        set{
            audioPlayer?.volume = newValue
        }
    }
    
    func play(){
        audioPlayer?.currentTime = 0
        audioPlayer?.play()
    }
}