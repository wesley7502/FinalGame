import SpriteKit

class Boss1: Enemy{    //Super Massive Boss with bullet rain
    
    var enemyMovementTimer: Double = 0.0
    var shooterTimer: Double = 0.0
    var shots: Int = 0
    var targetLane: Int = 0
    
    var theScene: GameScene?
    
    init(lane: Int, scene: GameScene) {
        
        theScene = scene
        
        let texture = SKTexture(imageNamed: "Boss1")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 320, height: 100), givenName: "boss1", points: 120, bd : 0, dif: 50, sp: 6, ty : "boss", la: lane)
        
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 3
        
        hitPoints += Double(theScene!.bossLevel) * 80.0
        
        maxHitPoints = hitPoints
        
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
        if(shooterTimer == 0.0){
            shooterTimer = currentTime
        }
        if hitPoints > maxHitPoints/2{
            if currentTime - enemyMovementTimer >= 0.15{
                let bulletPos = Int(arc4random_uniform(6) + 1)
                enemyShoot2(bulletPos)
                enemyMovementTimer = 0.0
            }
        }
            
        else{
            if currentTime - enemyMovementTimer >= 1.2{
                targetLane = (theScene?.planePos)!
                enemyMovementTimer = 0.0
                shooterTimer = 0.0
                shots = 0
            }
            else{
                if currentTime - shooterTimer >= 0.15 && shots <= 5{
                    enemyShoot(targetLane)
                    shooterTimer = currentTime
                    shots += 1
                }
            }

        }
        
    }
    
    func enemyShoot(pos: Int){
        
        let enemyBullet = TriangleBullet()
        
        enemyBullet.position = CGPoint(x: (Double)(pos) * 53.33 - 26.665, y: 500)
        
        theScene?.addChild(enemyBullet)
        theScene?.enemyBulletArray.append(enemyBullet)

    }
    
    func enemyShoot2(pos: Int){
        
        let enemyBullet = TrapezoidBullet()
        
        enemyBullet.position = CGPoint(x: (Double)(pos) * 53.33 - 26.665, y: 500)
        
        theScene?.addChild(enemyBullet)
        theScene?.enemyBulletArray.append(enemyBullet)
        
    }

    
}
