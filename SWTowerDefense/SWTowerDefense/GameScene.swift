//
//  GameScene.swift
//  SWTowerDefense
//
//  Created by Gabriel Borges on 4/6/16.
//  Copyright (c) 2016 Gabe Borges. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var critters = [Critter]()
    var towers = [Tower]()
    //var travelPoints = [TravelPoint]()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //let backgroundMap = SKSpriteNode(imageNamed: "baseBackground")
        //backgroundMap.position = CGPointMake(self.size.width/2, self.size.height/2)
        //backgroundMap.size = self.frame.size
        //self.addChild(backgroundMap)
        
        self.backgroundColor = SKColor.whiteColor()
        loadCritters()
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
            
            addChild(towerSprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // Update 
    }
    
    func loadCritters() {
        // Create content to handle waves && Adjust enemy difficulty based on wave number
        let spawnInterval = 1.0; let critterAmount = 10
        
        let delay = SKAction.waitForDuration(spawnInterval)
        
        let addCritter = SKAction.runBlock({
            [unowned self] in
            let critter = Critter()
            let initPoint = CGPoint(x: 0.0 , y: 650)
            critter.xScale = 0.01
            critter.yScale = 0.01
            critter.position = initPoint
            
            let pointTwo = CGPointMake(900, 650)
            let pointThree = CGPointMake(900, 450)
            let pointFour = CGPointMake(100, 450)
            let pointFive = CGPointMake(100, 250)
            let endPoint = CGPointMake(900, 250)
            
            let moveInitToTwo = SKAction.moveTo(pointTwo, duration: critter.walkSpeed)
            let moveToThree = SKAction.moveTo(pointThree, duration: critter.walkSpeed / 2.5)
            let moveToFour = SKAction.moveTo(pointFour, duration: critter.walkSpeed)
            let moveToFive = SKAction.moveTo(pointFive, duration: critter.walkSpeed / 2.5)
            let moveToEnd = SKAction.moveTo(endPoint, duration: critter.walkSpeed)
            
            let moveSequence = SKAction.sequence([moveInitToTwo, moveToThree, moveToFour, moveToFive, moveToEnd])
            critter.runAction(moveSequence)
            self.addChild(critter)
        })
        
        let loadAction = SKAction.sequence([delay, addCritter])
        
        runAction(SKAction.repeatAction(loadAction, count: critterAmount))
    }
    
    func towerCritterCollision(towerPoint: CGPoint, towerRange: CGFloat,
                               critterPoint: CGPoint, collisionRadius: CGFloat) -> Bool {
        // This function is called by the tower to test whether an enemy exits in
        // its attack range!
        
        let xDiff = towerPoint.x - critterPoint.x
        let yDiff = towerPoint.y - critterPoint.y
        let distance = sqrt(xDiff * xDiff + yDiff * yDiff)
        
        if (distance <= towerRange + collisionRadius) {
            return true
        }
        
        return false
    }
    
    func initTravelPoints() {
        // Function to initialize the Enemy travel points
        // Can be modified to work differently depending on the background "map"
    }

}
