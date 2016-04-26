//
//  GameOverScene.swift
//  SWTowerDefense
//
//  Created by Gabriel Borges on 4/26/16.
//  Copyright © 2016 Gabe Borges. All rights reserved.
//

import SpriteKit
import AVFoundation

@available(iOS 9.0, *)
class GameOverScene: SKScene {
    
    var backgroundMusic: AVAudioPlayer!
    
    override func didMoveToView(view: SKView) {
        let backgroundImage = SKSpriteNode(imageNamed: "gameOverBackground")
        backgroundImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        backgroundImage.size = self.size
        backgroundImage.zPosition = 0
        self.addChild(backgroundImage)
        
        let path = NSBundle.mainBundle().pathForResource("Order66_music.mp3", ofType:nil)!
        let url = NSURL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOfURL: url)
            backgroundMusic = sound
            sound.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let scene =  MenuScene(size: self.size)
            let skView = self.view! as SKView
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .ResizeFill
            scene.size = skView.bounds.size
            let transition = SKTransition.fadeWithDuration(1)
            skView.presentScene(scene, transition: transition)
        }
    }
}
