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
    var lives = 100
    var cash = 1000
    let livesLabel = SKLabelNode(fontNamed: "Arial")
    let cashLabel = SKLabelNode(fontNamed: "Arial")
    let endPoint = CGPoint(x: 900, y: 150)
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let backgroundMap = SKSpriteNode(imageNamed: "line")
        backgroundMap.position = CGPointMake(self.size.width/2, self.size.height/2)
        backgroundMap.size = CGSize(width: 512, height: 384)
        self.addChild(backgroundMap)
        
        self.backgroundColor = SKColor.whiteColor()
        livesLabel.fontSize = 30
        livesLabel.position = CGPointMake(100, 625)
        livesLabel.fontColor = UIColor.blackColor()
        
        cashLabel.fontSize = 30
        cashLabel.position = CGPointMake(300, 625)
        cashLabel.fontColor = UIColor.blackColor()
        
        updateLabels(cashChange: 0, livesChange: 0)
        
        self.addChild(livesLabel)
        self.addChild(cashLabel)
        loadCritters()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in (touches) {
            let location = touch.locationInNode(self)
            
            let tower = Tower()
            if (canAffordTower(tower.towerCost)) {
                
                tower.xScale = 0.1
                tower.yScale = 0.1
                tower.position = location
                addChild(tower)
                towers.append(tower)
                updateLabels(cashChange: tower.towerCost, livesChange: 0)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        critterIsAtEndCheck()
        
    }
    
    func loadCritters() {
        // Create content to handle waves && Adjust enemy difficulty based on wave number
        let spawnInterval = 1.0; let critterAmount = 10
        
        let delay = SKAction.waitForDuration(spawnInterval)
        
        let addCritter = SKAction.runBlock({
            [unowned self] in
            let critter = Critter()
            let initPoint = CGPoint(x: 0.0 , y: 550)
            critter.xScale = 0.01
            critter.yScale = 0.01
            critter.position = initPoint
            
            let pointTwo = CGPointMake(900, 550)
            let pointThree = CGPointMake(900, 350)
            let pointFour = CGPointMake(100, 350)
            let pointFive = CGPointMake(100, 150)
            
            let moveInitToTwo = SKAction.moveTo(pointTwo, duration: critter.walkSpeed)
            let moveToThree = SKAction.moveTo(pointThree, duration: critter.walkSpeed / 2.5)
            let moveToFour = SKAction.moveTo(pointFour, duration: critter.walkSpeed)
            let moveToFive = SKAction.moveTo(pointFive, duration: critter.walkSpeed / 2.5)
            let moveToEnd = SKAction.moveTo(self.endPoint, duration: critter.walkSpeed)
            
            let moveSequence = SKAction.sequence([moveInitToTwo, moveToThree, moveToFour, moveToFive, moveToEnd])
            critter.runAction(moveSequence)
            self.addChild(critter)
            self.critters.append(critter)
        })
        
        let loadAction = SKAction.sequence([delay, addCritter])
        
        runAction(SKAction.repeatAction(loadAction, count: critterAmount))
    }
    
    func towerCritterCollision(towerPoint: CGPoint, towerRange: CGFloat,
                               critterPoint: CGPoint, collisionRadius: CGFloat) -> Bool {
        // This function is called by the tower to test whether a critter exits in
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
        // Function to initialize the Critter travel points
        // Can be modified to work differently depending on the background "map"
    }
    
    func canAffordTower(cost: Int) -> Bool {
        if ((cash - cost) >= 0){
            return true
        }
        else{
            return false
        }
    }
    
    func updateLabels(cashChange cashChange: Int, livesChange: Int) {
        cash = cash - cashChange
        lives = lives - livesChange
        cashLabel.text = "Cash: " + String(cash)
        livesLabel.text = "Lives: " + String(lives)
    }
    
    func critterIsAtEndCheck() {
        for critter in critters {
            if (critter.position == endPoint) {
                critter.removeFromParent()
                updateLabels(cashChange: 0, livesChange: 1)
                let i = critters.indexOf(critter)
                critters.removeAtIndex(i!)
            }
        }
    }
    
    func updateTowerTarget() {
        // Run Loop for each Tower
            // Check if Tower does have target
                // If yes, is it in range?
                    // Yes = Continue attacking.
                    // No = Search for new Target
        
    }
    
    func findCritterForTower() {
        // Run Loop for each Tower
            // Sub-Loop in Enemies
                // For all enemies within target range: 
                    // Attack the one closest ****** THIS CODE CAN BE MODIFIED AS A GAME SETTING LATER******
            // If no enemies are within tower Range
                // Do nothing
    }
    
}
