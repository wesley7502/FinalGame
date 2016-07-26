import SpriteKit

class TargetLock: Enemy {
    
    var theScene: GameScene?
    var enemyMovementTimer: Double = 0.0
    
    init(lane: Int, scene: GameScene) {
        
        theScene = scene
        
        /* Initialize with 'bubble' asset */
        let texture = SKTexture(imageNamed: "TargetLock")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 72, height: 72), givenName: "targetlock", points: 10, bd: 0.005, dif: 2, sp: 1, ty : "target", la: lane)
        
        self.name = "TargetLock"
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 6
        
        self.position = scene.plane.position
        
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
        if currentTime - enemyMovementTimer >= 0.45 && !shooting{
            enemyShoot()
        }
        else if currentTime - enemyMovementTimer >= 0.6 && shooting{
            shooting = false
            theScene?.enemyArray.removeAtIndex((theScene?.enemyArray.indexOf(self)!)!)
            self.removeFromParent()
        }
    }
    
    func enemyShoot(){
        let shoot = SKAction(named: "TargetSight")!
        runAction(shoot)
        shooting = true
    }
}



