import SpriteKit

class Boss3: Enemy{
    
    var enemyMovementTimer: Double = 0.0
    var shooterTimer: Double = 0.0
    var shots: Int = 0
    var targetLane: Int = 0
    var di = true
    var squareLane = 0
    
    var turns = true  //go right if true go left if false
    
    var theScene: GameScene?
    
    init(lane: Int, scene: GameScene) {
        
        theScene = scene
        
        let texture = SKTexture(imageNamed: "Boss3")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 160, height: 53.33), givenName: "boss3", points: 80, bd : 0, dif: 10, sp: 6, ty : "boss", la: lane)
        
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 3
        
        squareLane = lane
        
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func enemyAction(currentTime: CFTimeInterval){
        if(enemyMovementTimer == 0.0){
            enemyMovementTimer = currentTime
        }
        if(shooterTimer == 0.0){
            shooterTimer = currentTime
        }
        if currentTime - enemyMovementTimer >= 0.75{
                repeat{
                    let change = Int(arc4random_uniform(2))
                    switch change{
                    case 0:
                        self.position.x += 53.33
                    case 1:
                        self.position.x -= 53.33
                    default:
                        break
                    }
                }
                while self.position.x < 79 || self.position.x > 241
            
                enemyShoot()
                if hitPoints < 40 && currentTime - shooterTimer > 1.5{
                    enemyShoot2()
                    shooterTimer = 0.0
                }
            enemyMovementTimer = 0.0
        }
    }
    
    func enemyShoot(){
        let square = Square(lane: 0)
        square.position = self.position
        theScene?.addChild(square)
        theScene?.enemyArray.append(square)
    }
    
    
    func enemyShoot2(){
        let triangle = Triangle(lane: 0, scene: theScene!)
        let enemyPos = Int(arc4random_uniform(6) + 1)
        triangle.position = CGPoint(x: (Double)(enemyPos) * 53.33 - 26.655, y: 600)
        theScene?.addChild(triangle)
        theScene?.enemyArray.append(triangle)
        
    }
    
}