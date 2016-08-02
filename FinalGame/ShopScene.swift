import SpriteKit

class ShopScene: SKScene {
    
    /* UI Connections */
    var buttonBack: MSButtonNode!
    var buyArmor: MSButtonNode!
    var buyDamage: MSButtonNode!
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonBack = self.childNodeWithName("buttonBack") as! MSButtonNode
        buyArmor = self.childNodeWithName("buyArmor") as! MSButtonNode
        buyDamage = self.childNodeWithName("buyDamage") as! MSButtonNode
        
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
            
        }
        
        buyDamage.selectedHandler = {
            
        }
        
    }
    
}