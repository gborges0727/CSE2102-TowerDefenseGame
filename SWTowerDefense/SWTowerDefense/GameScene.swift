//
//  GameScene.swift
//  SWTowerDefense
//
//  Created by Gabriel Borges on 4/6/16.
//  Copyright (c) 2016 Gabe Borges. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
        self.backgroundColor = SKColor.whiteColor()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            
            let towerSprite = SKSpriteNode(imageNamed:"blueSquare")
            
            towerSprite.xScale = 0.1
            towerSprite.yScale = 0.1
            towerSprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            towerSprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(towerSprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // Update 
    }
}

func handleWave() {
    // Create content to handle waves && Adjust enemy difficulty based on wave number
}

func initTravelPoints() {
    // Function to initialize the Enemy travel points
    // Can be modified to work differently depending on the background "map"
}

func towerEnemyCollision(towerPoint: CGPoint, towerRange: CGFloat,
                         enemyPoint: CGPoint, collisionRadius: CGFloat) -> Bool {
    // This function is called by the tower to test whether an enemy exits in 
    // its attack range!
    
    let xDiff = towerPoint.x - enemyPoint.x
    let yDiff = towerPoint.y - enemyPoint.y
    let distance = sqrt(xDiff * xDiff + yDiff * yDiff)
    
    if (distance <= towerRange + collisionRadius) {
        return true
    }
    
    return false
}
