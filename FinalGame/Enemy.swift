import SpriteKit

class Enemy: SKSpriteNode {
    
    var hitPoints: Double = 0.0        //health of opponenet
    var bodyDamage: CGFloat = 0   //body damage of opponent
    var identity: String = ""  // name of opponent
    var difficulty: Int = 0   //manages the difficulty level of opponents
    var spacing: Int = 0     //how much space the enemies takes up
    var type: String = ""   //if enemy is runner or shooter
    var lane: Int = 0       //determines the lane of the enemy
    
    
    
    var dead = false
    var shooting = false
    
    var exists: Bool = false {
        didSet {
            /* Visibility */
            hidden = !exists
        }
    }
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, givenName: String, points: Double, bd: CGFloat, dif: Int, sp: Int, ty: String, la: Int) {

        super.init(texture: texture, color: color, size: size)
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 2
        
        hitPoints = points
        
        bodyDamage = bd
        
        identity = givenName
        
        difficulty = dif
        
        spacing = sp
        
        type = ty
        
        lane = la
        
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func enemyAction(currentTime: CFTimeInterval){
        
    }
    
    func stopLazer(){}
    
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
