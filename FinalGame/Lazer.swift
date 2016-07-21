import SpriteKit

class Lazer: Enemy{
    
    var enemyMovementTimer: Double = 0.0
    var shooterTimer: Double = 0.0
    var shots: Int = 0
    var beam: LazerBullet?
    
    var theScene: GameScene?
    
    init(scene: GameScene) {
        
        theScene = scene
        
        let texture = SKTexture(imageNamed: "Lazer")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 64, height: 64), givenName: "lazer", points: 4, bd : 0.05, dif: 4)
        
        
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
        if(shooterTimer == 0.0){
            enemyShoot()
            shooterTimer = currentTime
            shooting = true
        }
        if currentTime - shooterTimer >= 4.0 && shooting{
            stopLazer()
            shooting = false
        }
        else if currentTime - shooterTimer >= 9.0{
            shooterTimer = 0.0
        }
    }
    
    func enemyShoot(){
        beam = LazerBullet(scene : theScene!)
        beam!.position = self.position
        theScene?.addChild(beam!)
        theScene?.enemyBulletArray.append(beam!)
    }
    
    override func stopLazer(){
        theScene?.enemyBulletArray.removeAtIndex((theScene?.enemyBulletArray.indexOf(beam!)!)!)
        beam!.removeFromParent()
    }
    
}

