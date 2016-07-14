//
//  GameScene.swift
//  FinalGame
//
//  Created by Tsai Family on 7/11/16.
//  Copyright (c) 2016 MakeSchool. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var plane: SKSpriteNode!
    var touchLoc: CGPoint!
    var planePos = 3
    
    var shooting = false
    
    var didTurn = false
    
    var checkTouchFinished = false
    
    var bulletArray = [Bullet]()
    
    var enemyBulletArray = [EnemyBullet]()
    
    var squareArray = [Square]()
    
    var enemyArray = [TriangleEnemy]()
    
    var touchStarted: Double = 0.0
    
    var obstacleStarted: Double = 0.0
    
    var enemyMovementTimer: Double = 0.0
    
    var bulletTimer: Double = 0.0
    
    
    
    override func didMoveToView(view: SKView) {
        plane = childNodeWithName("plane") as! SKSpriteNode
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            touchLoc = touch.locationInNode(self)
            shooting = true
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            didTurn = false
            let location  = touch.locationInNode(self)
            let calculateddistance = Double(touchLoc.x - location.x)
            if calculateddistance > 50 && planePos > 1{
                self.plane.position.x -= 64
                planePos -= 1
                didTurn = true
            }
            else if calculateddistance < -50 && planePos < 5{
                self.plane.position.x += 64
                planePos += 1
                didTurn = true
            }
            else{
            }
            shooting = false
            checkTouchFinished = true
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        planeFunctions(currentTime)
        obstacleFunctions(currentTime)
        enemyFunctions(currentTime)
        
    }
    
    func planeFunctions(currentTime: CFTimeInterval){
        if shooting{
            if(touchStarted == 0.0){  // starts tap action
                touchStarted = currentTime
            }
            else if((currentTime - touchStarted) > 0.2){ //if touching for more than 2 seconds shoot
                shoot(currentTime)
            }
        }
        if checkTouchFinished{ //Every time the touch ended, it checks the total time and decides shooting
            if(currentTime - touchStarted <= 0.1 && !didTurn){
                addNewBullet()
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
    }
    
    func obstacleFunctions(currentTime: CFTimeInterval){
        if squareArray.count == 0{
            addSquareRow()
        }
        if obstacleStarted == 0.0{
            obstacleStarted = currentTime
        }
        else if((currentTime - obstacleStarted) > 2.5){
            addSquareRow()
            obstacleStarted = 0.0
        }
        

        /* First move the squares down, then looks if it got hit but a bullet */
        if squareArray.count != 0{
            for square in squareArray{
                square.position.y -= 3
                if bulletArray.count != 0{
                    for bullet in bulletArray{
                        if abs(square.position.y - bullet.position.y) < 10 && abs(square.position.x - bullet.position.x) < 5{
                            bullet.removeFromParent()
                            bulletArray.removeAtIndex(bulletArray.indexOf(bullet)!)
                            square.hitPoints -= 1
                            square.runAction(SKAction.colorizeWithColor(UIColor.whiteColor(), colorBlendFactor: 1.0, duration: 0.5))
                        }
                    }
                }
                if square.hitPoints <= 0{
                    squareArray.removeAtIndex(squareArray.indexOf(square)!)
                    square.removeFromParent()
                }
                if square.position.y <= -32{
                    squareArray.removeAtIndex(squareArray.indexOf(square)!)
                    square.removeFromParent()
                }
            }
        }
        
    }
    
    func enemyFunctions(currentTime: CFTimeInterval){
        if enemyArray.count == 0{
            addNewEnemy()
        }
        if(enemyMovementTimer == 0.0){
            enemyMovementTimer = currentTime
        }
        for enemy in enemyArray{
            if currentTime - enemyMovementTimer >= 2.0{
                repeat{                                         //move the triangle in another direction
                    let change = Int(arc4random_uniform(3))
                    switch change{
                    case 0:
                        enemy.position.x += 64
                    case 1:
                        enemy.position.x -= 64
                    case 2:
                        enemy.position.x += 0
                    default:
                        break
                    }
                }
                while enemy.position.x < 32 || enemy.position.x > 288
                enemyShoot(enemy)
                enemyMovementTimer = 0.0
            }
            
            if bulletArray.count != 0{
                for bullet in bulletArray{
                    if abs(enemy.position.y - bullet.position.y) < 10 && abs(enemy.position.x - bullet.position.x) < 5{
                        bullet.removeFromParent()
                        bulletArray.removeAtIndex(bulletArray.indexOf(bullet)!)
                        enemy.hitPoints -= 1
                        print(enemy.hitPoints)
                        enemy.runAction(SKAction.colorizeWithColor(UIColor.whiteColor(), colorBlendFactor: 1.0, duration: 0.5))
                    }
                }
            }
            
            
            if enemy.hitPoints <= 0{
                enemyArray.removeAtIndex(enemyArray.indexOf(enemy)!)
                enemy.removeFromParent()
            }
            
        }
        
        if enemyBulletArray.count != 0{
            for bullet in enemyBulletArray{
                bullet.position.y -= 4
                if bullet.position.y <= -32{
                    enemyBulletArray.removeAtIndex(enemyBulletArray.indexOf(bullet)!)
                    bullet.removeFromParent()
                }
                
            }
        }
        
    }
    
    /* will add ONE row of squares*/
    func addSquareRow(){
        let numSquares = Int(arc4random_uniform(4) + 1)
        var controlSquareArray = [Int]()
        var squarePos = 0
        var squareCounter = 0
        while squareCounter < numSquares{
                repeat{
                    squarePos = Int(arc4random_uniform(5) + 1)
                }
                while(searchArray(controlSquareArray, x: squarePos))
                controlSquareArray.append(squarePos)
                squareCounter += 1
                addNewSquare(squarePos)
        }
    }
    
    /* return true if there if x is in arr*/
    func searchArray(arr: [Int], x: Int) -> Bool{
        if arr.count == 0{
            return false
        }
        else{
            for i in arr{
                if i == x{
                    return true
                }
            }
        }
        return false
        
    }
    
    func enemyShoot(foe: TriangleEnemy){
        let enemyBullet = EnemyBullet()
        enemyBullet.position = foe.position
        addChild(enemyBullet)
        enemyBulletArray.append(enemyBullet)
    }
    
    func shoot(currentTime: CFTimeInterval){
            let bulletWatch = currentTime - bulletTimer
            if bulletWatch >= 0.1 {
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
    
    func addNewSquare(squarePos: Int){
        let square = Square()
        square.position = CGPoint(x: squarePos * 64 - 32, y: 568)
        addChild(square)
        squareArray.append(square)
    }
    
    func addNewEnemy(){
        let triangle = TriangleEnemy()
        let enemyPos = Int(arc4random_uniform(5) + 1)
        triangle.position = CGPoint(x: enemyPos * 64 - 32, y: 530)
        addChild(triangle)
        enemyArray.append(triangle)
        
    }
}
