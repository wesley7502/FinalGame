import SpriteKit
import AVFoundation

class ShopScene: SKScene {
    
    /* UI Connections */
    var buttonBack: MSButtonNode!
    var buyArmor: MSButtonNode!
    var buyDamage: MSButtonNode!
    var buyBulletSpeed: MSButtonNode!
    var buyReload: MSButtonNode!
    
    var coinsLabel: SKLabelNode!
    var armorLabel: SKLabelNode!
    var damageLabel: SKLabelNode!
    var bulletSpeedLabel: SKLabelNode!
    var reloadLabel: SKLabelNode!
    
    var armorBar: SKSpriteNode!
    var damageBar: SKSpriteNode!
    var bulletSpeedBar: SKSpriteNode!
    var reloadBar: SKSpriteNode!
    
    var backgroundMusic: AVAudioPlayer!
      
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    
        
        /* Set UI connections */
        buttonBack = self.childNodeWithName("buttonBack") as! MSButtonNode
        buyArmor = self.childNodeWithName("buyArmor") as! MSButtonNode
        buyDamage = self.childNodeWithName("buyDamage") as! MSButtonNode
        buyBulletSpeed = self.childNodeWithName("buyBulletSpeed") as! MSButtonNode
        buyReload = self.childNodeWithName("buyReload") as! MSButtonNode
        
        coinsLabel = self.childNodeWithName("coinsLabel") as! SKLabelNode
        armorLabel = self.childNodeWithName("armorLabel") as! SKLabelNode
        damageLabel = self.childNodeWithName("damageLabel") as! SKLabelNode
        bulletSpeedLabel = self.childNodeWithName("bulletSpeedLabel") as! SKLabelNode
        reloadLabel = self.childNodeWithName("reloadLabel") as! SKLabelNode
        
        armorBar = self.childNodeWithName("armorBar") as! SKSpriteNode
        damageBar = self.childNodeWithName("damageBar") as! SKSpriteNode
        bulletSpeedBar = self.childNodeWithName("bulletSpeedBar") as! SKSpriteNode
        reloadBar = self.childNodeWithName("reloadBar") as! SKSpriteNode
        
        coinsLabel.text = "Coins: \(UserState.sharedInstance.coins)"
        armorLabel.text = "\(100 * (Int)(pow(Double(UserState.sharedInstance.armor + 1),2)))"
        damageLabel.text = "\(100 * (Int)(pow(Double(UserState.sharedInstance.damage + 1),2)))"
        bulletSpeedLabel.text = "\(100 * (Int)(pow(Double(UserState.sharedInstance.bulletSpeed + 1),2)))"
        reloadLabel.text = "\(100 * (Int)(pow(Double(UserState.sharedInstance.reload + 1),2)))"
        
        if UserState.sharedInstance.armor == 10{
            self.armorLabel.text = "FULL"
        }
        if UserState.sharedInstance.damage == 10{
            self.damageLabel.text = "FULL"
        }
        if UserState.sharedInstance.bulletSpeed == 10{
            self.bulletSpeedLabel.text = "FULL"
        }
        if UserState.sharedInstance.reload == 10{
            self.reloadLabel.text = "FULL"
        }
        
        armorBar.xScale = CGFloat(UserState.sharedInstance.armor) / 10.0
        damageBar.xScale = CGFloat(UserState.sharedInstance.damage) / 10.0
        bulletSpeedBar.xScale = CGFloat(UserState.sharedInstance.bulletSpeed) / 10.0
        reloadBar.xScale = CGFloat(UserState.sharedInstance.reload) / 10.0
        
        
        let path = NSBundle.mainBundle().pathForResource("Sunset Shop.mp3", ofType:nil)!
        let url = NSURL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOfURL: url)
            backgroundMusic = sound
            sound.numberOfLoops = -1
            sound.play()
        } catch {
            // couldn't load file :(
        }
        
        
        /* Setup restart button selection handler */
        buttonBack.selectedHandler = {
            
            
            if self.backgroundMusic != nil {
                self.backgroundMusic.stop()
                self.backgroundMusic = nil
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
        
        buyArmor.selectedHandler = {
            let armorCheck = UserState.sharedInstance.armor
            let coinsCheck = UserState.sharedInstance.coins
            let canBuy = 100 * (Int)(pow(Double(armorCheck + 1),2))
            if (coinsCheck > canBuy && armorCheck < 10){
                UserState.sharedInstance.armor += 1
                UserState.sharedInstance.coins -= 100 * (Int)(pow(Double(armorCheck + 1),2))
                self.coinsLabel.text = "Coins: \(UserState.sharedInstance.coins)"
                self.armorLabel.text = "\(100 * (Int)(pow(Double(UserState.sharedInstance.armor + 1),2)))"
                if UserState.sharedInstance.armor == 10{
                    self.armorLabel.text = "FULL"
                }
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
                if UserState.sharedInstance.damage == 10{
                    self.damageLabel.text = "FULL"
                }
                self.damageBar.xScale = CGFloat(UserState.sharedInstance.damage) / 10.0
            }
        }
        
        buyBulletSpeed.selectedHandler = {
            let bulletSpeedCheck = UserState.sharedInstance.bulletSpeed
            let coinsCheck = UserState.sharedInstance.coins
            let canBuy = 100 * (Int)(pow(Double(bulletSpeedCheck + 1),2))
            if (coinsCheck > canBuy && bulletSpeedCheck < 10){
                UserState.sharedInstance.bulletSpeed += 1
                UserState.sharedInstance.coins -= 100 * (Int)(pow(Double(bulletSpeedCheck + 1),2))
                self.coinsLabel.text = "Coins: \(UserState.sharedInstance.coins)"
                self.bulletSpeedLabel.text = "\(100 * (Int)(pow(Double(UserState.sharedInstance.bulletSpeed + 1),2)))"
                if UserState.sharedInstance.bulletSpeed == 10{
                    self.bulletSpeedLabel.text = "FULL"
                }
                self.bulletSpeedBar.xScale = CGFloat(UserState.sharedInstance.bulletSpeed) / 10.0
            }
        }
        
        
        buyReload.selectedHandler = {
            let reloadCheck = UserState.sharedInstance.reload
            let coinsCheck = UserState.sharedInstance.coins
            let canBuy = 100 * (Int)(pow(Double(reloadCheck + 1),2))
            if (coinsCheck > canBuy && reloadCheck < 10){
                UserState.sharedInstance.reload += 1
                UserState.sharedInstance.coins -= 100 * (Int)(pow(Double(reloadCheck + 1),2))
                self.coinsLabel.text = "Coins: \(UserState.sharedInstance.coins)"
                self.reloadLabel.text = "\(100 * (Int)(pow(Double(UserState.sharedInstance.reload + 1),2)))"
                if UserState.sharedInstance.reload == 10{
                    self.reloadLabel.text = "FULL"
                }
                self.reloadBar.xScale = CGFloat(UserState.sharedInstance.reload) / 10.0
            }
        }
        
    }
    
}