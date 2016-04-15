//
//  Enemy.swift
//  SWTowerDefense
//
//  Created by Gabriel Borges on 4/6/16.
//  Copyright (c) 2016 Gabe Borges. All rights reserved.
//

import SpriteKit
import GameplayKit


class Critter: SKSpriteNode {
    // var scene: SKScene!
    let walkSpeed = 10.0
    let lifeHealth = 50
    var nextPoint = 0
    
    init() {
        let texture = SKTexture(imageNamed: "redSquare")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        // Function used to call other functions and update the stats
    }
    
    func calcDamage() {
        // Function to calculate the damage taken by a tower
    }
    
    func changeTravelPoint() {
        // Function to change the current travel point to the next point
    }
}
