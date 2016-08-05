//
//  Boss7.swift
//  FinalGame
//
//  Created by Tsai Family on 8/3/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import SpriteKit

class Boss7: Enemy{    //Super Massive Boss with bullet rain
    
    var enemyMovementTimer: Double = 0.0
    var shooterTimer: Double = 0.0
    var shots: Int = 0
    var targetLane: Int = 0
    
    var theScene: GameScene?
    
    init(lane: Int, scene: GameScene) {
        
        theScene = scene
        
        let texture = SKTexture(imageNamed: "Boss7")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 320, height: 100), givenName: "boss7", points: 120, bd : 0, dif: 50, sp: 6, ty : "boss", la: lane)
        
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 3
        
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let enter = SKAction(named: "EpicEnterance")!
        self.runAction(enter)
        
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func enemyAction(currentTime: CFTimeInterval){
        if(enemyMovementTimer == 0.0){
            enemyMovementTimer = currentTime
        }
        if hitPoints > 50{
            if currentTime - enemyMovementTimer >= 1.5{
                enemyShoot()
                enemyMovementTimer = 0.0
            }
        }
        else{
            if currentTime - enemyMovementTimer >= 0.9{
                enemyShoot2()
                enemyMovementTimer = 0.0
            }
        }
        
    }
    
    
    func enemyShoot2(){
        
        for i in 1...6{
            let bulletPos = CGPointMake(((CGFloat)(i) * 53.33), self.position.y)
            let enemyBullet = MissileBullet(ownPos: bulletPos, targetPos: theScene!.plane.position)
            theScene?.addChild(enemyBullet)
            theScene?.enemyBulletArray.append(enemyBullet)
        }
        
    }
    
    
    func enemyShoot(){
        var controlSquareArray = [Int]()
        var squarePos = 0
        var squareCounter = 0
        while squareCounter < 4{
            repeat{
                squarePos = Int(arc4random_uniform(6) + 1)
            }
                while(searchArray(controlSquareArray, x: squarePos))
            controlSquareArray.append(squarePos)
            squareCounter += 1
            let enemyBullet = Square(lane: 0)
            
            enemyBullet.position = CGPoint(x: (Double)(squarePos) * 53.33 - 26.665, y: 500)
            
            theScene?.addChild(enemyBullet)
            theScene?.enemyArray.append(enemyBullet)
        }
    }
    
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

    
    
}
