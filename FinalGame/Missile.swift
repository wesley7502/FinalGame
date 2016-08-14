import SpriteKit

class Missile: Enemy{
    
    var enemyMovementTimer: Double = 0.0
    var shooterTimer: Double = 0.0
    var shots: Int = 0
    
    var theScene: GameScene?
    
    init(lane: Int, scene: GameScene) {
        
        theScene = scene
        
        let texture = SKTexture(imageNamed: "Missile")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 53.33, height: 53.33), givenName: "missile", points: 8, bd : 0.04, dif: 5,  sp: 2, ty : "shooter", la: lane)
        
        
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
            enemyShoot()
            shooterTimer = 0.0
            enemyMovementTimer = 0.0
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
        
        let leftBulletPos = CGPointMake(self.position.x, self.position.y)
        
        let enemyBullet = MissileBullet(ownPos: leftBulletPos, targetPos: theScene!.plane.position)
        theScene?.addChild(enemyBullet)
        theScene?.enemyBulletArray.append(enemyBullet)    }
}