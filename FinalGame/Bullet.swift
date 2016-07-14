import SpriteKit

class Bullet: SKSpriteNode {
    
    var exists: Bool = true {
        didSet {
            /* Visibility */
            hidden = !exists
        }
    }
    
    init() {
        /* Initialize with 'bubble' asset */
        let texture = SKTexture(imageNamed: "Bullet")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 25, height: 25))
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 1
        
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
