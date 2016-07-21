import SpriteKit

class EnemyBullet: SKSpriteNode {
    
    var damage: CGFloat = 0
    
    var exists: Bool = false {
        didSet {
            /* Visibility */
            hidden = !exists
        }
    }
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, d: CGFloat) {
        
        super.init(texture: texture, color: color, size: size)
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 1
        
        damage = d
        
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func bulletAction(){
        
    }
    
}
