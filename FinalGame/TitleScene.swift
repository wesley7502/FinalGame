import SpriteKit
import AVFoundation

class TitleScene: SKScene {
    
    /* UI Connections */
    var buttonPlay: MSButtonNode!
    var titleMusic: AVAudioPlayer!
    
    override func didMoveToView(view: SKView) {
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
    
}