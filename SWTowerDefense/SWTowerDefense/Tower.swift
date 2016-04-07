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
class Tower: GKComponent {
    
    var scene: GameScene!
    var sprite: SKSpriteNode!
    var attackRange = 10
    var damage = 10
    var fireRate = 1
    var towerCost = 100
    
    init(scene: GameScene, sprite: SKSpriteNode) {
        self.scene = scene
        self.sprite = sprite
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
