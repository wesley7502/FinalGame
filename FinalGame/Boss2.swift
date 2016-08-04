import SpriteKit

class Boss2: Enemy{   //Circle Boss with Lock On Target
    
    var enemyMovementTimer: Double = 0.0
    var shooterTimer: Double = 0.0
    var shots: Int = 0
    var targetLane: Int = 0
    var di = true
    
    var turns = true  //go right if true go left if false
    
    var theScene: GameScene?
    
    init(lane: Int, scene: GameScene) {
        
        theScene = scene
        
        let texture = SKTexture(imageNamed: "Boss2")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 160, height: 160), givenName: "boss2", points: 80, bd : 0, dif: 50, sp: 6, ty : "boss", la: lane)
        
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 3
        
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
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
        if self.position.x < 80 || self.position.x > 240{    //turning mechanisms
            turns = !turns
        }
        if turns{
            self.position.x += 2
        }
        else{
            self.position.x -= 2
        }
        if currentTime - enemyMovementTimer >= 0.5{
                enemyShoot()
                enemyMovementTimer = 0.0
        }
        if hitPoints < 50{
            if(currentTime - shooterTimer >= 2){
                enemyShoot2()
                shooterTimer = 0.0
            }
        }
    }
    
    func enemyShoot(){
        let enemyBullet = CircleBullet(scene: theScene!, direction: di)
        enemyBullet.position = self.position
        theScene?.addChild(enemyBullet)
        theScene?.enemyBulletArray.append(enemyBullet)
        di = !di
    }

    
    func enemyShoot2(){
        
        let enemyBullet = TargetLock(lane: 0, scene : theScene!)
        theScene?.addChild(enemyBullet)
        theScene?.enemyArray.append(enemyBullet)
        
    }
    
    
}
