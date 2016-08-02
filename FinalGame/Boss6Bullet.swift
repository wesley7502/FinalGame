import SpriteKit

class Boss6Bullet: EnemyBullet {
    var direction = 0
    
    init(di: Int) {
        /* Initialize with 'bubble' asset */
        let texture = SKTexture(imageNamed: "TriangleBullet")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 25, height: 25), d: 0.01)
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 1
        
        direction = di
        
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0.5, y: 1)
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func bulletAction(){
        switch direction{
            case 1:
                self.position.y += 4
            case 2:
                self.position.y -= 4
            
            case 3:
                self.position.x -= 4
            
            case 4:
                self.position.x += 4
            
            case 5:
                self.position.y += 4
                self.position.x -= 4
            
            case 6:
                self.position.y += 4
                self.position.x += 4
            
            case 7:
                self.position.y -= 4
                self.position.x -= 4
            
            case 8:
                self.position.y -= 4
                self.position.x += 4
            
            default:
                break
            
            }
        
    }
}
