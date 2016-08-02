import SpriteKit

class Boss5: Enemy{
    
    var enemyMovementTimer: Double = 0.0
    var shooterTimer: Double = 0.0
    var shots: Int = 0
    var targetLane: Int = 0
    var goRight = true
    var squareLane = 0
    var interval = 0.5
    
    
    
    var turns = true  //go right if true go left if false
    
    var theScene: GameScene?
    
    init(lane: Int, scene: GameScene) {
        
        theScene = scene
        
        let texture = SKTexture(imageNamed: "Boss5")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 53.33, height: 53.33), givenName: "boss5", points: 60, bd : 0, dif: 50, sp: 6, ty : "boss", la: lane)
        
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 3
        
        squareLane = lane
        
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
        if currentTime - enemyMovementTimer >= interval{
            if self.position.x < 53.33 || self.position.x > 266.67{    //turning mechanisms
                goRight = !goRight
            }
            if goRight{
                self.position.x += 53.33
            }
            else{
                self.position.x -= 53.33
            }
            
            if hitPoints > 30{
                enemyShoot()
            }
            else{
            
                enemyShoot2()
                interval = 0.75
            }
            enemyMovementTimer = 0.0
        }
    }
    
    func enemyShoot(){
        let enemyBullet = TriangleBullet()
        enemyBullet.position = self.position
        theScene?.addChild(enemyBullet)
        theScene?.enemyBulletArray.append(enemyBullet)
    }
    
    
    func enemyShoot2(){
        let leftBulletPos = CGPointMake(self.position.x, self.position.y)
        
        let enemyBullet = MissileBullet(ownPos: leftBulletPos, targetPos: theScene!.plane.position)
        theScene?.addChild(enemyBullet)
        theScene?.enemyBulletArray.append(enemyBullet)

        
    }
    
}