import SpriteKit

class Trapezoid: Enemy{
    
    var enemyMovementTimer: Double = 0.0
    var shooterTimer: Double = 0.0
    var shots: Int = 0
    
    var theScene: GameScene?
    
    init(scene: GameScene) {
        
        theScene = scene
        
        let texture = SKTexture(imageNamed: "Trapezoid-1")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 128, height: 64), givenName: "trapezoid", points: 4, bd : 0.04, dif: 3)
        
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 2
        
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
        
        if currentTime - enemyMovementTimer >= 6.0{
            repeat{                                         //move the trapezoid in another direction
                let change = Int(arc4random_uniform(3))
                switch change{
                case 0:
                    self.position.x += 64
                case 1:
                    self.position.x -= 64
                case 2:
                    self.position.x += 0
                default:
                    break
                }
            }
            while self.position.x < 64 || self.position.x > 256
            enemyShoot()
            enemyMovementTimer = 0.0
            shooterTimer = 0.0
            shots = 0
        }
        else{
            if currentTime - shooterTimer >= 0.5 && shots < 3{
                enemyShoot()
                shooterTimer = currentTime
                shots += 1
            }
        }
    }
    
    func enemyShoot(){
        let enemyBullet = TrapezoidBullet()
        enemyBullet.position = self.position
        enemyBullet.position.x -= 32.0
        theScene?.addChild(enemyBullet)
        theScene?.enemyBulletArray.append(enemyBullet)
        
        let enemyBullet2 = TrapezoidBullet()
        enemyBullet2.position = self.position
        enemyBullet2.position.x += 32.0
        theScene?.addChild(enemyBullet2)
        theScene?.enemyBulletArray.append(enemyBullet2)
    }
    
    
}
