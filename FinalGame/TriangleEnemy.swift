import SpriteKit

class TriangleEnemy: SKSpriteNode {
    
    var hitPoints = 7
    
    var lane = 1
    
    var exists: Bool = false {
        didSet {
            /* Visibility */
            hidden = !exists
        }
    }
    
    init() {
        /* Initialize with 'bubble' asset */
        let texture = SKTexture(imageNamed: "TriangleEnemy")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 64, height: 64))
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 2
        
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
