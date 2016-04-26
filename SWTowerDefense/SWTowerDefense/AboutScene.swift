//
//  AboutScene.swift
//  SWTowerDefense
//
//  Created by Gabriel Borges on 4/22/16.
//  Copyright © 2016 Gabe Borges. All rights reserved.
//

import SpriteKit

@available(iOS 9.0, *)
class AboutScene: SKScene {
    
    var backButton: SKSpriteNode!
    var authorsButton: SKSpriteNode!
    var howToButton: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "menu_about")
        background.position = CGPointMake(self.size.width/2, self.size.height/2)
        background.size = self.size
        background.zPosition = 0
        self.addChild(background)
        
        backButton = SKSpriteNode(imageNamed: "button_back")
        backButton.position = CGPointMake(50, self.size.height - 50)
        backButton.size = CGSize(width: 50, height: 50)
        backButton.zPosition = 1
        self.addChild(backButton)
        
        howToButton = SKSpriteNode(imageNamed: "button_howTo")
        howToButton.position = CGPointMake(200, 75)
        howToButton.size = CGSize(width: 200, height: 175)
        howToButton.zPosition = 1
        self.addChild(howToButton)
        
        authorsButton = SKSpriteNode(imageNamed: "button_authors")
        authorsButton.position = CGPointMake(self.size.width - 200, 75)
        authorsButton.size = CGSize(width: 200, height: 175)
        authorsButton.zPosition = 1
        self.addChild(authorsButton)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if (backButton.containsPoint(location)) {
                let scene =  MenuScene(size: self.size)
                let skView = self.view! as SKView
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = skView.bounds.size
                let transition = SKTransition.fadeWithDuration(1)
                skView.presentScene(scene, transition: transition)
            }
            
            if (howToButton.containsPoint(location)) {
                let scene =  HowToPlayScene(size: self.size)
                let skView = self.view! as SKView
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = skView.bounds.size
                let transition = SKTransition.fadeWithDuration(1)
                skView.presentScene(scene, transition: transition)
            }
                
            else if (authorsButton.containsPoint(location)) {
                let scene = AuthorsScene(size: self.size)
                let skView = self.view! as SKView
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = skView.bounds.size
                let transition = SKTransition.fadeWithDuration(1)
                skView.presentScene(scene, transition: transition)
            }
        }
    }
}
