//
//  Bullet.swift
//  SWTowerDefense
//
//  Created by Gabriel Borges on 4/14/16.
//  Copyright © 2016 Gabe Borges. All rights reserved.
//

import SpriteKit

class Bullet: SKSpriteNode {
    
    let travelSpeed = 0.5
    var critterTarget: Critter!
    var damageDone: Int!
    var destinationPoint: CGPoint!
    
    init() {
        let texture = SKTexture(imageNamed: "bullet.png")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
