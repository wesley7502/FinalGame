import SpriteKit

class Enemy: SKSpriteNode {
    
    var hitPoints: Int = 0
    var bodyDamage: CGFloat = 0
    var identity: String = ""
    var difficulty: Int = 0
    
    var exists: Bool = false {
        didSet {
            /* Visibility */
            hidden = !exists
        }
    }
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, givenName: String, points: Int, bd: CGFloat, dif: Int) {

        super.init(texture: texture, color: color, size: size)
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 2
        
        hitPoints = points
        
        bodyDamage = bd
        
        identity = givenName
        
        difficulty = dif
        
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func enemyAction(currentTime: CFTimeInterval){
        
    }
    
    func gotHit(bulletArray: [Bullet]) -> Bool{
        if bulletArray.count != 0{
            for bullet in bulletArray{
                if abs(self.position.y - self.position.y) < 10 && abs(self.position.x - bullet.position.x) < 5{
                    return true
                }
            }
        }
        return false
    }
    
    func getName() -> String{
        return identity
    }
    
}
