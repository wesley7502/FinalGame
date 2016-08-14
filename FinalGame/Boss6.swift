import SpriteKit

class Boss6: Enemy{ //The OctoShot
    
    var enemyMovementTimer: Double = 0.0
    var shooterTimer: Double = 0.0
    var interval = 2.0

    
    var theScene: GameScene?
    
    init(lane: Int, scene: GameScene) {
        
        theScene = scene
        
        let texture = SKTexture(imageNamed: "Boss6")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 53.33, height: 53.33), givenName: "boss6", points: 100, bd : 0.001, dif: 75, sp: 6, ty : "boss", la: lane)
        
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 3
        
        hitPoints += Double(theScene!.bossLevel) * 60.0
        
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
        if self.position.y > 150{
            self.position.y -= 0.75
        }
        else{
            self.position.y -= 5
        }
        if self.position.y <= -25{
            let newPos = Int(arc4random_uniform(6) + 1)
            self.position = CGPoint(x: (Double)(newPos) * 53.33 - 26.665, y: 530)
        }
        if currentTime - enemyMovementTimer >= 3{
            repeat{
                let change = Int(arc4random_uniform(2))
                switch change{
                case 0:
                    self.position.x += 53.33
                case 1:
                    self.position.x -= 53.33
                default:
                    break
                }
            }
            while self.position.x < 0 || self.position.x > 320
            enemyMovementTimer = 0.0
        }
        
        if currentTime - shooterTimer > interval{
            enemyShoot()
            if hitPoints <= maxHitPoints/2{
                interval = 1.5
                enemyShoot2()
            }
            shooterTimer = 0.0
        }
        
        
    }
    
    func enemyShoot(){
        for index in 1...4 {
            let enemyBullet = Boss6Bullet(di: index)
            enemyBullet.position = self.position
            theScene?.addChild(enemyBullet)
            theScene?.enemyBulletArray.append(enemyBullet)
        }
    }
    
    
    func enemyShoot2(){
        for index in 5...8 {
            let enemyBullet = Boss6Bullet(di: index)
            enemyBullet.position = self.position
            theScene?.addChild(enemyBullet)
            theScene?.enemyBulletArray.append(enemyBullet)
        }
        
    }
    
}