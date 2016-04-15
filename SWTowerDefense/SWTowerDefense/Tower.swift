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
    var sprite: SKSpriteNode!
    var attackRange = CGFloat(100)
    var damage = 10
    var fireRate = 0.5
    var towerCost = 100
    var currentEnemy: Critter!
    var canFire = false
    var bullets = [Bullet]()
    
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
        if(canFire) {
            let delay = SKAction.waitForDuration(self.fireRate)
            
            let addBullet = SKAction.runBlock({
                [unowned self] in
                let bullet = Bullet()
                let initPoint = CGPointMake(self.position.x / 2, self.position.y / 2)
                bullet.xScale = 0.1
                bullet.yScale = 0.1
                bullet.position = initPoint
                bullet.critterTarget = self.currentEnemy
                bullet.destinationPoint = bullet.critterTarget.position
                
                let moveToCritter = SKAction.moveTo(bullet.critterTarget.position, duration: bullet.travelSpeed)
                let bulletDie = SKAction.removeFromParent()
                
                let bulletSpawn = SKAction.sequence([moveToCritter, bulletDie])
                bullet.runAction(bulletSpawn)
                self.currentEnemy.addChild(bullet)
                self.bullets.append(bullet)
                })
            
            let loadAction = SKAction.sequence([addBullet, delay])
            runAction(SKAction.repeatActionForever(loadAction))
        }
        else {
            removeAllActions()
        }
    }
    
    func deadEnemy() {
        // Function used to handle when the tower loses sight of the enemy
    }
}
