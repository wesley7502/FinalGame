import SpriteKit

class MissileBullet: EnemyBullet {
    
    var xTarget: CGFloat = 0.0
    var yTarget: CGFloat = 0.0
    
    init(ownPos: CGPoint, targetPos: CGPoint) {
        /* Initialize with 'bubble' asset */
        let texture = SKTexture(imageNamed: "MissleBullet")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 32, height: 32), d: 0.03)
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 1
        
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.position = ownPos
        
        
        let diffx: CGFloat = targetPos.x - (self.position.x)
        let diffy: CGFloat = targetPos.y - (self.position.y)
        let vec = CGVectorMake(diffx, diffy)
        
        let goTime = vec.length()/300
        
        let angleDiff = vec.angle
        print(angleDiff)
        
        let rotate = SKAction.rotateByAngle(angleDiff, duration: 0.5)
        let move = SKAction.moveBy(vec, duration: NSTimeInterval(goTime))
        let moveForever = SKAction.repeatActionForever(move)
        let sequence = SKAction.sequence([rotate,moveForever])
        self.runAction(sequence)
        
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func bulletAction(){
    }
}