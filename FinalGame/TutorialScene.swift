//
//  TutorialScene.swift
//  FinalGame
//
//  Created by Tsai Family on 7/27/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import SpriteKit

class TutorialScene: SKScene {
    
    var plane: SKSpriteNode!
    var touchLoc: CGPoint!
    var planePos = 3
    var healthBar: SKSpriteNode!
    var tutorialLabel: SKLabelNode!
    var turnCounter = 0
    
    var stasis = false //determines if game will "freeze" or not
    
    var unlock = false
    
    var tutorialTimer: Double = 0.0    //times the tutorial
    
    var bulletTimer: Double = 0.0    // manages bullets
    var touchStarted: Double = 0.0   //timer that updates the tap and holding fuctions

    var breakTime: Double = 1.0
    
    var tutorialState = 0

    var killCount = 0
    var killtime = false
    
    var health: CGFloat = 1.0{
        didSet{
            healthBar.xScale = health
        }
    }
    
    var shooting = false
    
    var didTurn = false
    
    var checkTouchFinished = false
    
    var bulletArray = [Bullet]()
    
    var enemyBulletArray = [EnemyBullet]()
    
    var enemyArray = [Enemy]()
    
    
    
    
    override func didMoveToView(view: SKView) {
        plane = childNodeWithName("plane") as! SKSpriteNode
        healthBar = childNodeWithName("healthbar") as! SKSpriteNode
        tutorialLabel = childNodeWithName("tutoriallabel") as! SKLabelNode
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            touchLoc = touch.locationInNode(self)
            shooting = true
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location  = touch.locationInNode(self)
            let calculateddistance = Double(touchLoc.x - location.x)
            if calculateddistance > 65 && planePos > 1 && (tutorialState == 1 || unlock){
                planePos -= 1
                if self.plane.position.y < 268{
                    let flipL = SKAction(named: "SlideLeft")!
                    self.plane.runAction(flipL)
                }
                else{
                    let flipL = SKAction(named: "MoveLeft")!
                    self.plane.runAction(flipL)
                }
                turnCounter += 1
                didTurn = true
            }
            else if calculateddistance < -65 && planePos < 6 && (tutorialState == 1 || unlock){
                planePos += 1
                if self.plane.position.y < 268{
                    let flipR = SKAction(named: "SlideRight")!
                    self.plane.runAction(flipR)
                }
                else{
                    let flipR = SKAction(named: "MoveRight")!
                    self.plane.runAction(flipR)
                }
                turnCounter += 1
                didTurn = true
            }
            else if touchLoc.y - location.y > 60 && self.plane.position.y > 32 && (tutorialState == 2 || unlock){  //move down
                let flipD = SKAction(named: "MoveDown")!
                self.plane.runAction(flipD)
                didTurn = true
                turnCounter += 1
            }
            else if location.y - touchLoc.y > 60 && self.plane.position.y < 500 && (tutorialState == 2 || unlock){   //move up
                let flipU = SKAction(named: "MoveUp")!
                self.plane.runAction(flipU)
                didTurn = true
                turnCounter += 1
            }
            
            shooting = false
            checkTouchFinished = true
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        if !stasis && !killtime{
            tutorialFunctions(currentTime)
        }
        else if killtime{
            if killCount >= 5{
                /* Grab reference to our SpriteKit view */
                let skView = self.view as SKView!
                
                /* Load Game scene */
                let scene = GameScene(fileNamed:"GameScene") as GameScene!
                
                /* Ensure correct aspect mode */
                scene.scaleMode = .AspectFit
                
                /* Show debug */
                skView.showsDrawCount = true
                skView.showsFPS = true
                
                /* Start game scene */
                skView.presentScene(scene)
                
            }
            
        }
        else if turnCounter > 4{
            stasis = false
            turnCounter = 0
            tutorialTimer = 0.0
        }
        
        planeFunctions(currentTime)
        enemyFunctions(currentTime)
        
    }
    
    func tutorialFunctions(currentTime: CFTimeInterval){
        if tutorialTimer == 0.0{
            tutorialTimer = currentTime
        }
        else if currentTime - tutorialTimer > breakTime{
            
            stasis = true
            
            if tutorialState  == 0{
                tutorialLabel.text = "Slide Left and Right"
            }
            else if tutorialState  == 1{
                tutorialLabel.text = "Slide Up and Down"
            }
            else if tutorialState  == 2{
                tutorialLabel.text = "Tap to Shoot"
            }
            else if tutorialState  == 3{
                tutorialLabel.text = "Hold to Barrage"
            }
            else if tutorialState == 4{
                tutorialLabel.text = "Try Everything"
                unlock = true
                breakTime += 4
            }
            else if unlock && killCount == 0{
                tutorialLabel.text = "Kill Some Squares"
                addNewSquare()
                killtime = true
                stasis = false
            }
            tutorialState += 1
            tutorialTimer = 0.0
        }
     
        
        
    }
    
    
    
    func planeFunctions(currentTime: CFTimeInterval){
        if shooting{      //the shooter manager
            if(touchStarted == 0.0){  // starts tap action
                touchStarted = currentTime
            }
            else if((currentTime - touchStarted) > 0.2 && (tutorialState == 4 || unlock)){ //if touching for more than 2 seconds shoot
                shoot(currentTime)
                turnCounter += 1
            }
        }
        if checkTouchFinished{ //Every time the touch ended, it checks the total time and decides shooting
            if(currentTime - touchStarted <= 0.15 && !didTurn && (tutorialState == 3 || unlock)){
                addNewBullet()
                turnCounter += 1
            }
            touchStarted = 0.0
            checkTouchFinished = false
        }
        if bulletArray.count != 0{
            for bullet in bulletArray{
                bullet.position.y += 10
                if bullet.position.y >= 600{
                    bulletArray.removeAtIndex(bulletArray.indexOf(bullet)!)
                    bullet.removeFromParent()
                }
            }
        }
        
        //now manages the movement of the plane
        if !didTurn && !shooting && !stasis{
            self.plane.position.y -= 1.25
        }
        else if shooting && !stasis{
            self.plane.position.y -= 0.5
        }
        didTurn = false
        
        
        //now manages the plane's Health bar
        let currentpos = self.plane.position
        
        if enemyBulletArray.count != 0{    // collision with enemy bullets
            for ebullet in enemyBulletArray{
                
                let calculatePlaneY = (self.plane.position.y + self.plane.size.height/2 ) - (ebullet.position.y - ebullet.size.height)  //distance between end bullet and top of plane
                let calculatePlaneX = abs(self.plane.position.x - ebullet.position.x)
                if calculatePlaneY > 0 && calculatePlaneY < self.plane.size.height/2 && calculatePlaneX < self.plane.size.width/2 {
                    if(ebullet.damage != 0.001){
                        enemyBulletArray.removeAtIndex(enemyBulletArray.indexOf(ebullet)!)
                        ebullet.removeFromParent()
                    }
                    health -= ebullet.damage
                }
                
            }
        }
        
        if enemyArray.count != 0{    // collision with enemies
            for enemy in enemyArray{
                let scanpos = enemy.position
                let calculateddistance = sqrt(pow(Double(scanpos.x - currentpos.x),2.0) + pow(Double(scanpos.y - currentpos.y),2.0))
                if calculateddistance < (Double(enemy.size.height) / 2 + 25) && enemy.type == "runner" {
                    enemyArray.removeAtIndex(enemyArray.indexOf(enemy)!)
                    let explode = SKAction(named: "Explode")!
                    let remove = SKAction.removeFromParent()
                    let sequence = SKAction.sequence([explode,remove])
                    enemy.runAction(sequence)
                    health -= enemy.bodyDamage
                    addNewSquare()
                    killCount += 1
                }
            }
        }
        
        if currentpos.y < 15 {
            self.plane.position.y += 150
            health -= 0.1
            
        }
        
    }
    
    
    func enemyFunctions(currentTime: CFTimeInterval){
        
        for enemy in enemyArray{     //implements enemy bullet detection
            enemy.enemyAction(currentTime)
            if bulletArray.count != 0{
                for bullet in bulletArray{
                    let calculateBulletX = abs(enemy.position.x - bullet.position.x)
                    let calculateBulletY = abs(enemy.position.y - bullet.position.y)
                    let disX =  enemy.size.width / 2
                    let disY = enemy.size.height / 2
                    
                    if calculateBulletY < disY && calculateBulletX < disX {
                            bullet.removeFromParent()
                            bulletArray.removeAtIndex(bulletArray.indexOf(bullet)!)
                            enemy.hitPoints -= 1
                    }
                }
            }
            if enemy.hitPoints <= 0{        //Checks if enemy is dead
                
                
                enemyArray.removeAtIndex(enemyArray.indexOf(enemy)!)
                
                
                let explode = SKAction(named: "Explode")!
                let remove = SKAction.removeFromParent()
                let sequence = SKAction.sequence([explode,remove])
                enemy.runAction(sequence)
                addNewSquare()
                killCount += 1
            }
            if enemy.position.y <= -32{    //squares will erase if below -32
                enemyArray.removeAtIndex(enemyArray.indexOf(enemy)!)
                enemy.removeFromParent()
                addNewSquare()
            }
        }
        
        
        if enemyBulletArray.count != 0{       // manages the enemy bullet movement
            for bullet in enemyBulletArray{
                bullet.bulletAction()
                if bullet.position.y <= -32{
                    enemyBulletArray.removeAtIndex(enemyBulletArray.indexOf(bullet)!)
                    bullet.removeFromParent()
                }
                
            }
        }
        
    }
    
    func addNewSquare(){
        let enemyPos = Int(arc4random_uniform(6) + 1)
        let enemy = Square(lane: enemyPos)
        enemy.position = CGPoint(x: (Double)(enemyPos) * 53.33 - 26.665, y: 600)
        addChild(enemy)
        enemyArray.append(enemy)
    }
    
    
    
    func shoot(currentTime: CFTimeInterval){
        let bulletWatch = currentTime - bulletTimer
        if bulletWatch >= 0.15 {
            addNewBullet()
            bulletTimer = currentTime
        }
    }
    
    
    
    func addNewBullet(){
        let bullet = Bullet()
        bullet.position = self.plane.position
        addChild(bullet)
        bulletArray.append(bullet)
    }
}
