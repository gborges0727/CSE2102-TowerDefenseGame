//
//  Tower.swift
//  
//
//  Created by Gabriel Borges on 4/6/16.
//
//

import UIKit
import SpriteKit

class Tower: SKSpriteNode {
    
    var attackRange = 10
    var damage = 10
    var fireRate = 1
    
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
