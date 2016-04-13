//
//  Tower.swift
//  
//
//  Created by Gabriel Borges on 4/6/16.
//
//

import GameplayKit
import SpriteKit

@available(iOS 9.0, *)
class Tower: SKSpriteNode {
    
    // var scene = SKScene() NOT sure if needed?
    var sprite: SKSpriteNode!
    var attackRange = 10
    var damage = 10
    var fireRate = 1
    var towerCost = 100
    var currentEnemy: SKSpriteNode!
    
    init() {
        let texture = SKTexture(imageNamed: "blueSquare")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectEnemy() {
        // Function used to get a target enemy
    }
    
    func isFiring() {
        // Function to continously fire the tower
    }
    
    func deadEnemy() {
        // Function used to handle when the tower loses sight of the enemy
    }
}
