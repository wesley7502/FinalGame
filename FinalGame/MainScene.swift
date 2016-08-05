import SpriteKit

class MainScene: SKScene {
    
    /* UI Connections */
    var buttonPlay: MSButtonNode!
    var buttonShop: MSButtonNode!
    var resetTutorial: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonPlay = self.childNodeWithName("playButton") as! MSButtonNode
        buttonShop = self.childNodeWithName("shopButton") as! MSButtonNode
        resetTutorial = self.childNodeWithName("resetTutorial") as! MSButtonNode
        
        /* Setup restart button selection handler */
        buttonPlay.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            var scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            
            if UserState.sharedInstance.didTutorial == false{
            /* Load Game scene */
               scene = TutorialScene(fileNamed:"TutorialScene") as TutorialScene!
                UserState.sharedInstance.didTutorial = true
            }
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFit
            
            /* Show debug */
            skView.showsDrawCount = true
            skView.showsFPS = true
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        buttonShop.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = ShopScene(fileNamed:"ShopScene") as ShopScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFit
            
            /* Show debug */
            skView.showsDrawCount = true
            skView.showsFPS = true
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        resetTutorial.selectedHandler = {
            UserState.sharedInstance.didTutorial = false
        }
        
    }
    
}