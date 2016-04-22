//
//  AboutScene.swift
//  SWTowerDefense
//
//  Created by Gabriel Borges on 4/22/16.
//  Copyright © 2016 Gabe Borges. All rights reserved.
//

import SpriteKit

class AboutScene: SKScene {
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "menu_about")
        background.position = CGPointMake(self.size.width/2, self.size.height/2)
        background.size = self.size
        background.zPosition = 0
        self.addChild(background)
    }
}
