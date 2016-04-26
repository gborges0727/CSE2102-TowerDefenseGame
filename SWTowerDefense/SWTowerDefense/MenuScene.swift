//
//  MenuScene.swift
//  SWTowerDefense
//
//  Created by Gabriel Borges on 4/6/16.
//  Copyright (c) 2016 Gabe Borges. All rights reserved.
//

import SpriteKit
import AVFoundation

@available(iOS 9.0, *)
class MenuScene: SKScene {
    
    var playButton: SKSpriteNode! = nil
    var aboutButton: SKSpriteNode! = nil
    var backgroundMusic: AVAudioPlayer!
    
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "menu_main")
        background.position = CGPointMake(self.size.width/2, self.size.height/2)
        background.size = self.size
        background.zPosition = 0
        self.addChild(background)
        
        playButton = SKSpriteNode(imageNamed: "button_play")
        playButton.position = CGPointMake(200, 135)
        playButton.size = CGSize(width: 200, height: 175)
        playButton.zPosition = 1
        self.addChild(playButton)
        
        aboutButton = SKSpriteNode(imageNamed: "button_about")
        aboutButton.position = CGPointMake(self.size.width - 200, 135)
        aboutButton.size = CGSize(width: 200, height: 175)
        aboutButton.zPosition = 1
        self.addChild(aboutButton)
        
        let path = NSBundle.mainBundle().pathForResource("CantinaTheme.mp3", ofType:nil)!
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
            let location = touch.locationInNode(self)
            
            if (playButton.containsPoint(location)) {
                let scene =  GameScene(size: self.size)
                let skView = self.view! as SKView
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = skView.bounds.size
                let transition = SKTransition.fadeWithDuration(1)
                skView.presentScene(scene, transition: transition)
            }
            
            else if (aboutButton.containsPoint(location)) {
                let scene = AboutScene(size: self.size)
                let skView = self.view! as SKView
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = skView.bounds.size
                let transition = SKTransition.fadeWithDuration(1)
                skView.presentScene(scene, transition: transition)
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
}
