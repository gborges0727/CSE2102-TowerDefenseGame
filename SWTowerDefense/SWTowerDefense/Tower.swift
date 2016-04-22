//
//  Tower.swift
//  
//
//  Created by Gabriel Borges on 4/6/16.
//
//

import GameplayKit
import SpriteKit

class Tower: SKSpriteNode {
    
    // var scene = SKScene() NOT sure if needed?
    var level = 1
    var sprite: SKSpriteNode!
    var attackRange = CGFloat(100)
    var damage = 10
    var towerCost = 100
    var fireRate = NSTimeInterval(0.5)
    var lastFireTime = NSTimeInterval(0)
    var lastUpdateTime = NSTimeInterval(0)
    

    //var level = 1
    var upgradeCost = 100
    var currentEnemy: Critter!
    var canFire = false
    var bullets = [Bullet]()
    
    init() {
        let texture = SKTexture(imageNamed: "towerY")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectEnemy() {
        // Function used to get a target enemy
    }
    
    func deadEnemy() {
        // Function used to handle when the tower loses sight of the enemy
    }
}
