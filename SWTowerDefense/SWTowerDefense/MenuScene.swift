//
//  MenuScene.swift
//  SWTowerDefense
//
//  Created by Gabriel Borges on 4/6/16.
//  Copyright (c) 2016 Gabe Borges. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var playButton: SKSpriteNode! = nil
    var aboutButton: SKSpriteNode! = nil
    
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "menu_main")
        background.position = CGPointMake(self.size.width/2, self.size.height/2)
        background.size = self.size
        background.zPosition = 0
        self.addChild(background)
        
        playButton = SKSpriteNode(imageNamed: "button_play")
        playButton.position = CGPointMake(200, 100)
        playButton.size = CGSize(width: 100, height: 75)
        playButton.zPosition = 1
        self.addChild(playButton)
        
        aboutButton = SKSpriteNode(imageNamed: "button_about")
        aboutButton.position = CGPointMake(400, 100)
        aboutButton.size = CGSize(width: 100, height: 75)
        aboutButton.zPosition = 1
        self.addChild(aboutButton)
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
                let scene =  AboutScene(size: self.size)
                let skView = self.view! as SKView
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = skView.bounds.size
                skView.presentScene(scene)
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
}
