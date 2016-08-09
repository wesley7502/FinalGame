import SpriteKit

class Triangle: Enemy{
    
    var enemyMovementTimer: Double = 0.0
    
    var theScene: GameScene?
    
    init(lane: Int, scene: GameScene) {
        
        theScene = scene
        
        let texture = SKTexture(imageNamed: "TriangleEnemy")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 53.33, height: 53.33), givenName: "triangle", points: 3, bd: 0.06, dif: 2, sp: 1, ty : "runner", la: lane)
        
        
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
        if currentTime - enemyMovementTimer >= 1.5{
            enemyShoot()
            enemyMovementTimer = 0.0
        }
        self.position.y -= 4
    }
    
    func enemyShoot(){
        let enemyBullet = TriangleBullet()
        enemyBullet.position = self.position
        theScene?.addChild(enemyBullet)
        theScene?.enemyBulletArray.append(enemyBullet)
    }

    
}
