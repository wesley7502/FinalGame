import SpriteKit

class ShopScene: SKScene {
    
    /* UI Connections */
    var buttonBack: MSButtonNode!
    var buyArmor: MSButtonNode!
    var buyDamage: MSButtonNode!
    var coinsLabel: SKLabelNode!
    var armorLabel: SKLabelNode!
    var damageLabel: SKLabelNode!
    var armorBar: SKSpriteNode!
    var damageBar: SKSpriteNode!
      
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonBack = self.childNodeWithName("buttonBack") as! MSButtonNode
        buyArmor = self.childNodeWithName("buyArmor") as! MSButtonNode
        buyDamage = self.childNodeWithName("buyDamage") as! MSButtonNode
        coinsLabel = self.childNodeWithName("coinsLabel") as! SKLabelNode
        armorLabel = self.childNodeWithName("armorLabel") as! SKLabelNode
        damageLabel = self.childNodeWithName("damageLabel") as! SKLabelNode
        armorBar = self.childNodeWithName("armorBar") as! SKSpriteNode
        damageBar = self.childNodeWithName("damageBar") as! SKSpriteNode
        
        coinsLabel.text = "Coins: \(UserState.sharedInstance.coins)"
        armorLabel.text = "\(100 * (Int)(pow(Double(UserState.sharedInstance.armor + 1),2)))"
        damageLabel.text = "\(100 * (Int)(pow(Double(UserState.sharedInstance.damage + 1),2)))"
        armorBar.xScale = CGFloat(UserState.sharedInstance.armor) / 10.0
        damageBar.xScale = CGFloat(UserState.sharedInstance.damage) / 10.0
        
        /* Setup restart button selection handler */
        buttonBack.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = MainScene(fileNamed:"MainScene") as MainScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFit
            
            /* Show debug */
            skView.showsDrawCount = true
            skView.showsFPS = true
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        buyArmor.selectedHandler = {
            let armorCheck = UserState.sharedInstance.armor
            let coinsCheck = UserState.sharedInstance.coins
            let canBuy = 100 * (Int)(pow(Double(armorCheck + 1),2))
            if (coinsCheck > canBuy && armorCheck < 10){
                UserState.sharedInstance.armor += 1
                UserState.sharedInstance.coins -= 100 * (Int)(pow(Double(armorCheck + 1),2))
                self.coinsLabel.text = "Coins: \(UserState.sharedInstance.coins)"
                self.armorLabel.text = "\(100 * (Int)(pow(Double(UserState.sharedInstance.armor + 1),2)))"
                self.armorBar.xScale = CGFloat(UserState.sharedInstance.armor) / 10.0
            }
        }
        
        buyDamage.selectedHandler = {
            let damageCheck = UserState.sharedInstance.damage
            let coinsCheck = UserState.sharedInstance.coins
            let canBuy = 100 * (Int)(pow(Double(damageCheck + 1),2))
            if (coinsCheck > canBuy && damageCheck < 10){
                UserState.sharedInstance.damage += 1
                UserState.sharedInstance.coins -= 100 * (Int)(pow(Double(damageCheck + 1),2))
                self.coinsLabel.text = "Coins: \(UserState.sharedInstance.coins)"
                self.damageLabel.text = "\(100 * (Int)(pow(Double(UserState.sharedInstance.damage + 1),2)))"
                self.damageBar.xScale = CGFloat(UserState.sharedInstance.damage) / 10.0
            }
        }
        
    }
    
}