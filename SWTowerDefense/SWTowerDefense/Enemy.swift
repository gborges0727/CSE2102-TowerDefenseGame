//
//  Enemy.swift
//  SWTowerDefense
//
//  Created by Gabriel Borges on 4/6/16.
//  Copyright (c) 2016 Gabe Borges. All rights reserved.
//

import SpriteKit

class Enemy {
    let parentScene = GameScene
    let walkSpeed = 1
    var lifeHealth = 50
    var nextPoint = 0
    var travelPoint = TravelPoint()
    
    
    
    func update() {
        // Function used to call other functions and update the stats
    }
    
    func calcDamage() {
        // Function to calculate the damage taken by a tower
    }
    
    func changeTravelPoint(currentPoint: TravelPoint) {
        // Function to change the current travel point to the next point
    }
}
