import SpriteKit
import AVFoundation
import GameKit

class TitleScene: SKScene {
    
    /* UI Connections */
    var buttonPlay: MSButtonNode!
    var titleMusic: AVAudioPlayer!
    
    override func didMoveToView(view: SKView) {
        
        self.view?.showsFPS = false
        self.view?.showsNodeCount = false
        self.view?.showsDrawCount = false
        self.view?.showsFields = false
        
        /* Setup your scene here */
        /* Set UI connections */
        buttonPlay = self.childNodeWithName("playbutton") as! MSButtonNode
    
        
        let songDelay = SKAction.waitForDuration(3)
        let playSong = SKAction.runBlock({
        
                let path = NSBundle.mainBundle().pathForResource("Brixton Decision.mp3", ofType:nil)!
                let url = NSURL(fileURLWithPath: path)
                
                do {
                    let sound = try AVAudioPlayer(contentsOfURL: url)
                    self.titleMusic = sound
                    sound.numberOfLoops = -1
                    sound.play()
                } catch {
                // couldn't load file :(
                }
        })
        
        let transition = SKAction.sequence([songDelay,playSong])
        self.runAction(transition)
        
        authenticateLocalPlayer()
        
        /* Setup restart button selection handler */
        buttonPlay.selectedHandler = {
            
            if self.titleMusic != nil {
                self.titleMusic.stop()
                self.titleMusic = nil
            }
            
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
        
    }
    
    //This function checks if the player is logged in or not. If not, it will prompt the user to login into gamecenter.
    func authenticateLocalPlayer() {
        
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = { (viewController, error) -> Void in
            
            if viewController != nil {
                
                let vc:UIViewController = self.view!.window!.rootViewController!
                vc.presentViewController(viewController!, animated: true, completion: nil)
                
            } else {
                
                
            }
        }
    }
    
    
}