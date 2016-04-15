//
//  GameScene.swift
//  SWTowerDefense
//
//  Created by Gabriel Borges on 4/6/16.
//  Copyright (c) 2016 Gabe Borges. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let critterCategory = UInt32(0x1)
    let bulletCategory = UInt32(0x1 << 1)
    let sceneCategory = UInt32(0x1 << 2)
    
    var critters = [Critter]()
    var towers = [Tower]()
    var bullets = [Bullet]()
    var shootTimer = NSTimer()
    var lives = 100
    var cash = 1000
    let livesLabel = SKLabelNode(fontNamed: "Arial")
    let cashLabel = SKLabelNode(fontNamed: "Arial")
    let endPoint = CGPoint(x: 900, y: 150)
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        
        
        let backgroundMap = SKSpriteNode(imageNamed: "line")
        backgroundMap.position = CGPointMake(self.size.width/2, self.size.height/2)
        backgroundMap.size = CGSize(width: 512, height: 384)
        self.addChild(backgroundMap)
        
        self.backgroundColor = SKColor.blackColor()
        livesLabel.fontSize = 30
        livesLabel.position = CGPointMake(100, 625)
        livesLabel.fontColor = UIColor.whiteColor()
        
        cashLabel.fontSize = 30
        cashLabel.position = CGPointMake(300, 625)
        cashLabel.fontColor = UIColor.whiteColor()
        
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
                updateLabels(cashChange: -tower.towerCost, livesChange: 0)
                updateTowersTarget()
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        updateBulletPositions()
        critterIsAtEndCheck()
        updateTowersTarget()
        //bulletsCheck()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let firstBody = contact.bodyA.node as! Critter
        let secondBody = contact.bodyB.node as! Bullet
        
        if (contact.bodyA.categoryBitMask == critterCategory) && (contact.bodyB.categoryBitMask == bulletCategory ) {
            secondBody.removeFromParent()
            firstBody.health -= 50
            if (firstBody.health <= 0) {
                firstBody.removeFromParent()
                updateLabels(cashChange: 50, livesChange: 0)
            }
        }
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
            critter.physicsBody = SKPhysicsBody(rectangleOfSize: critter.size)
            critter.physicsBody!.dynamic = false
            critter.physicsBody!.categoryBitMask = self.critterCategory
            
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
        cash = cash + cashChange
        lives = lives + livesChange
        cashLabel.text = "Cash: " + String(cash)
        livesLabel.text = "Lives: " + String(lives)
    }
    
    func critterIsAtEndCheck() {
        for critter in critters {
            if (critter.position == endPoint) {
                critter.removeFromParent()
                updateLabels(cashChange: 0, livesChange: -1)
                let i = critters.indexOf(critter)
                critters.removeAtIndex(i!)
            }
        }
    }
    
    // I'm almost 100% sure the below code is VERY innefficient...
    
    func updateTowersTarget() {
        // Run Loop for each tower
        for tower in towers {
            updateBulletPositions()
            // Check if Tower doesn't have target
            if (tower.currentEnemy != nil) {
                let distance = calcDistance(firstPoint: tower.position, secondPoint: tower.currentEnemy.position)
                if (distance < tower.attackRange) {
        
                }
                else {
                    tower.canFire = false
                    findCritterForTower(tower)
                }
            }
            // Tower doesn't have an enemy :(
            else {
                findCritterForTower(tower)
                if (tower.currentEnemy == nil) {
                    tower.canFire = false
                }
            }
        }
    }
    
    func findCritterForTower(tower: Tower) {
        var currentClosestCritter = Critter()
        var currentClosestCritterDistance = CGFloat(-1)
        
        // Sub-Loop in Critters - always targets closest critter
        for critter in critters {
            let critterDistance = calcDistance(firstPoint: critter.position, secondPoint: tower.position)
            if (critterDistance < tower.attackRange && critterDistance > currentClosestCritterDistance) {
                currentClosestCritter = critter
                currentClosestCritterDistance = critterDistance
            }
        }
        
        if (currentClosestCritterDistance == CGFloat(-1)) {
            return
        }
        else {
            tower.currentEnemy = currentClosestCritter
            tower.canFire = true
            //shootTimer = NSTimer.scheduledTimerWithTimeInterval(tower.fireRate, target: self, selector: Selector(fireTower(tower)), userInfo: nil, repeats: tower.canFire)
            fireTower(tower)
        }
    }
    
    func updateBulletPositions() {
        for bullet in bullets {
            if (bullet.position == bullet.critterTarget.position) {
                bullet.removeFromParent()
                let i = bullets.indexOf(bullet)
                bullets.removeAtIndex(i!)
            }
            else {
                let location = bullet.critterTarget.position
                
                let dx = location.x - bullet.position.x
                let dy = location.y - bullet.position.y
                let angle = atan2(dy, dx)
                
                bullet.rotationAngle = angle
                
                let vx = cos(angle) * bullet.travelSpeed
                let vy = sin(angle) * bullet.travelSpeed
                
                bullet.position.x += vx
                bullet.position.y += vy
            }
        }
    }
    
    func fireTower(tower: Tower) {
        if(tower.canFire) {
            
            let bullet = Bullet()
            let initPoint = tower.position
            bullet.xScale = 0.005
            bullet.yScale = 0.005
            bullet.position = initPoint
            bullet.critterTarget = tower.currentEnemy
            bullet.destinationPoint = bullet.critterTarget.position
            bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width/2)
            bullet.physicsBody!.categoryBitMask = self.bulletCategory
            bullet.physicsBody!.usesPreciseCollisionDetection = true
            bullet.physicsBody!.collisionBitMask = bulletCategory | critterCategory
            bullet.physicsBody!.contactTestBitMask = bulletCategory | critterCategory
                
            self.addChild(bullet)
            self.bullets.append(bullet)
        }
        else {
            updateBulletPositions()
        }
    }
    
    func calcDistance(firstPoint firstPoint: CGPoint, secondPoint: CGPoint) -> CGFloat {
        let xDist = (secondPoint.x - firstPoint.x)
        let yDist = (secondPoint.y - firstPoint.y)
        return sqrt(xDist * xDist + yDist * yDist)
    }
}
