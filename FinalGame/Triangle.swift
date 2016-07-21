import SpriteKit

class Triangle: Enemy{
    
    var enemyMovementTimer: Double = 0.0
    
    var theScene: GameScene?
    
    init(scene: GameScene) {
        
        theScene = scene
        
        let texture = SKTexture(imageNamed: "TriangleEnemy")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 64, height: 64), givenName: "triangle", points: 2, bd: 0.04, dif: 2)
        
        
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
        if currentTime - enemyMovementTimer >= 1.0{
            enemyShoot()
            enemyMovementTimer = 0.0
        }
        self.position.y -= 3
    }
    
    func enemyShoot(){
        let enemyBullet = TriangleBullet()
        enemyBullet.position = self.position
        theScene?.addChild(enemyBullet)
        theScene?.enemyBulletArray.append(enemyBullet)
    }

    
}
