import SpriteKit

class LazerBullet: EnemyBullet {
    
    var theScene: GameScene?
    
    init(scene: GameScene) {
        
        theScene = scene
        
        /* Initialize with 'bubble' asset */
        let texture = SKTexture(imageNamed: "LazerBullet")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 32, height: 64), d: 0.001)
        
        self.name = "Lazer Bullet"
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 1
        
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0.5, y: 1)
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func bulletAction(){
        let calculatePlaneY = theScene!.plane.position.y - (self.position.y - self.size.height)
        let calculatePlaneX = abs(theScene!.plane.position.x - self.position.x)
        if calculatePlaneY > 0 && calculatePlaneX < 20{
            self.size.height -= calculatePlaneY
        }
        else if self.size.height < 550{
            self.size.height += 12
        }
    }
}