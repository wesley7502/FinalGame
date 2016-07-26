import SpriteKit

class CircleBullet: EnemyBullet {
    
    var theScene: GameScene?
    
    var planePos: CGPoint = CGPoint(x: 0,y: 0)
    
    var xspeed: CGFloat = 6.0
    
    var yspeed: CGFloat = 0
    
    var di = true
    
    init(scene: GameScene, direction: Bool) {
        
        theScene = scene
        
        /* Initialize with 'bubble' asset */
        let texture = SKTexture(imageNamed: "CircleBullet")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 32, height: 32), d: 0.02)
        
        self.name = "Circle Bullet"
        
        planePos = scene.plane.position
        
        di = direction
        
        if direction == true{
            xspeed = -6.0
        }
        
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
        self.position.x -= xspeed
        if di == true{
            xspeed += 0.2
        }
        else{
            xspeed -= 0.2
        }
        
        
        self.position.y -= yspeed
        yspeed += 0.4
        
    }
}
