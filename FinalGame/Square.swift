import SpriteKit

class Square: Enemy {
    
    init(lane: Int) {
        
        let texture = SKTexture(imageNamed: "Square")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 53.33, height: 53.33), givenName: "square", points: 8, bd : 0.04, dif: 1, sp: 1, ty : "runner", la: lane)
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 1
        
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
    }
    
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func enemyAction(currentTime: CFTimeInterval){
        self.position.y -= 2.5
        
    }
}
