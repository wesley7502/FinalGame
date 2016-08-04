//
//  GameScene.swift
//  FinalGame
//
//  Created by Tsai Family on 7/11/16.
//  Copyright (c) 2016 MakeSchool. All rights reserved.
//

import SpriteKit

/* Tracking enum for game state */
enum GameState {
    case GameOver, Survival, Paused
}



class GameScene: SKScene {
    
    var plane: SKSpriteNode!
    var touchLoc: CGPoint!
    var planePos = 3
    var healthBar: SKSpriteNode!
    let fixedDelta: CFTimeInterval = 1.0/60.0
    var scrollLayer: SKNode!
    var scoreLabel: SKLabelNode!
    var distanceLabel: SKLabelNode!
    var finalScoreLabel: SKLabelNode!
    var distanceScoreLabel: SKLabelNode!
    var restart: MSButtonNode!
    var toMain: MSButtonNode!
    var pause: MSButtonNode!
    
    
    
    var realScore: Int = 0 {
        didSet {
            scoreLabel.text = "\(realScore)"
        }
    }
    
    var distance: Int = 0 {
        didSet {
            distanceLabel.text = "\(distance)m"
        }
    }
    
    
    var distanceTimer: Double = 0.0      //The timer that manageDistance
    
    var scrollSpeed: CGFloat = 120
    
    var state: GameState = .Survival
    var shouldMove = true
    
    
    var tutorialTimer: Double = 0.0    //times the tutorial
    
    var bossTrigger = false
    
    var health: CGFloat = 1.0{
        didSet{
            healthBar.xScale = health
        }
    }
    
    var damage = UserState.sharedInstance.damage
    var armor = UserState.sharedInstance.armor
    
    
    var totalDifficulty = 1      // limits how hard of enemies can come
    
    var enemyValueCount = 10   //shows the amount of value and enemy can have
    
    var tempEnemyValueCount = 10   // helps set the enemy value count
    
    var bossCounter = 50.0//shows the count till the boss fight
    
    var spawnQuene = 0
    
    var laneCounter = 0 //tracks the amount of space taken both in the quene and in action
    
    var shooting = false
    
    var didTurn = false
    
    var checkTouchFinished = false
    
    var bossAlert = false
    
    var queneArray = [Int]()   // the array that quenes Enemies and empties out at a constant rate
    
    var shooterSpacingArray = [Int]()  //manages the rate at which shooters like Trapezoid and lazer Spawns
    
    var bulletArray = [Bullet]()
    
    var enemyBulletArray = [EnemyBullet]()
    
    var enemyArray = [Enemy]()
    
    var queneTimer: Double = 0.0      //timer that updates the quene
    
    var touchStarted: Double = 0.0   //timer that updates the tap and holding fuctions
    
    var bulletTimer: Double = 0.0    // manages bullets
    
    var difficultyTimer: Double = 0.0 //manages the difficulty increase through time
    
    var bossGeneratorTimer: Double = 0.0 //manages the implementation of bosses
    
    
    
    override func didMoveToView(view: SKView) {
        plane = childNodeWithName("plane") as! SKSpriteNode
        healthBar = childNodeWithName("healthBar") as! SKSpriteNode
        scrollLayer = self.childNodeWithName("scrollLayer")
        
        scoreLabel = childNodeWithName("scoreLabel") as! SKLabelNode
        distanceLabel = childNodeWithName("distanceLabel") as! SKLabelNode
        
        finalScoreLabel = childNodeWithName("finalScoreLabel") as! SKLabelNode
        
        distanceScoreLabel = childNodeWithName("distanceScoreLabel") as! SKLabelNode
        
        
        restart = self.childNodeWithName("restart") as! MSButtonNode
        toMain = self.childNodeWithName("toMain") as! MSButtonNode
        pause = self.childNodeWithName("pauseButton") as! MSButtonNode
        
        restart.selectedHandler = {
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart game scene */
            skView.presentScene(scene)
            
            
            /* Hide restart button */
            
        }
        restart.state = .MSButtonNodeStateHidden
        
        toMain.selectedHandler = {
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = MainScene(fileNamed:"MainScene") as MainScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart game scene */
            skView.presentScene(scene)
            
            
            /* Hide restart button */
            
        }
        toMain.state = .MSButtonNodeStateHidden
        
        pause.selectedHandler = {
            if self.state == .Survival{
                self.state = .Paused
            }
            else if self.state == .Paused{
                self.state = .Survival
            }
            
        }
        restart.state = .MSButtonNodeStateHidden
        

        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if state == .Survival{
        for touch in touches {
            touchLoc = touch.locationInNode(self)
            shooting = true
        }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if state == .Survival{
        
        for touch in touches {
            let location  = touch.locationInNode(self)
            let calculateddistance = Double(touchLoc.x - location.x)
            if calculateddistance > 50 && planePos > 1{
                planePos -= 1
                if self.plane.position.y < 268{
                    let flipL = SKAction(named: "SlideLeft")!
                    self.plane.runAction(flipL)
                }
                else{
                    let flipL = SKAction(named: "MoveLeft")!
                    self.plane.runAction(flipL)
                }
                didTurn = true
            }
            else if calculateddistance < -50 && planePos < 6{
                planePos += 1
                if self.plane.position.y < 268{
                    let flipR = SKAction(named: "SlideRight")!
                    self.plane.runAction(flipR)
                }
                else{
                    let flipR = SKAction(named: "MoveRight")!
                    self.plane.runAction(flipR)
                }
                didTurn = true
            }
            else if touchLoc.y - location.y > 60 && self.plane.position.y > 32{  //move down
                let flipD = SKAction(named: "MoveDown")!
                self.plane.runAction(flipD)
                didTurn = true
            }
            else if location.y - touchLoc.y > 60 && self.plane.position.y < 268{   //move up
                let flipU = SKAction(named: "MoveUp")!
                self.plane.runAction(flipU)
                didTurn = true
            }
            
            shooting = false
            checkTouchFinished = true
        }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        if state == .Survival{
            planeFunctions(currentTime)
            enemyFunctions(currentTime)
            if bossTrigger == false{
                checkDifficulty(currentTime)
                checkQuene(currentTime)
            }
            scrollWorld()
            manageDistance(currentTime)
            print(currentTime - bossGeneratorTimer)
        }
    }
    
    
    
    
    func planeFunctions(currentTime: CFTimeInterval){
        if shooting{      //the shooter manager
            if(touchStarted == 0.0){  // starts tap action
                touchStarted = currentTime
            }
            else if((currentTime - touchStarted) > 0.2){ //if touching for more than 2 seconds shoot
                shoot(currentTime)
            }
        }
        if checkTouchFinished{ //Every time the touch ended, it checks the total time and decides shooting
            if(currentTime - touchStarted <= 0.15 && !didTurn){
                addNewBullet()
            }
            touchStarted = 0.0
            checkTouchFinished = false
        }
        if bulletArray.count != 0{
            for bullet in bulletArray{
                bullet.position.y += 10
                if bullet.position.y >= 600{
                    bulletArray.removeAtIndex(bulletArray.indexOf(bullet)!)
                    bullet.removeFromParent()
                }
            }
        }
        
        //now manages the movement of the plane
        if !didTurn && !shooting{
            self.plane.position.y -= 1.25
        }
        else if shooting{
            self.plane.position.y -= 0.5
        }
        didTurn = false
        
        
        //now manages the plane's Health bar
        let currentpos = self.plane.position
        
        if enemyBulletArray.count != 0{    // collision with enemy bullets
            for ebullet in enemyBulletArray{
                
                let calculatePlaneY = abs(self.plane.position.y - ebullet.position.y)  
                let calculatePlaneX = abs(self.plane.position.x - ebullet.position.x)
                if(ebullet.damage != 0.002){
                    if calculatePlaneY < self.plane.size.height/2 && calculatePlaneX < self.plane.size.width/2 {
                        health -= ebullet.damage * CGFloat(1 - ((Double)(armor) * 0.05))
                        enemyBulletArray.removeAtIndex(enemyBulletArray.indexOf(ebullet)!)
                        ebullet.removeFromParent()
                    }
                }
                else{
                    if (ebullet.position.y - ebullet.size.height) < (self.plane.position.y + self.plane.size.height/2) && calculatePlaneX < self.plane.size.width/2 {
                        health -= ebullet.damage * CGFloat(1 - ((Double)(armor) * 0.05))
                    }
                }
                
            }
        }
        
        if enemyArray.count != 0{    // collision with enemies
            for enemy in enemyArray{
                let scanpos = enemy.position
                let calculateddistance = sqrt(pow(Double(scanpos.x - currentpos.x),2.0) + pow(Double(scanpos.y - currentpos.y),2.0))
                if calculateddistance < (Double(enemy.size.height) / 2 + 25) && enemy.type != "target" {
                    if enemy.type == "runner"{
                        enemyArray.removeAtIndex(enemyArray.indexOf(enemy)!)
                        enemyValueCount += enemy.difficulty
                        realScore += enemy.difficulty
                        let explode = SKAction(named: "Explode")!
                        let remove = SKAction.removeFromParent()
                        let sequence = SKAction.sequence([explode,remove])
                        enemy.runAction(sequence)
                        
                    }
                    health -= enemy.bodyDamage * CGFloat(1 - ((Double)(armor) * 0.05))
                }
                else if enemy.type == "target" && enemy.shooting == true && calculateddistance < Double(enemy.size.height) / 2 {
                        health -= enemy.bodyDamage * CGFloat(1 - ((Double)(armor) * 0.05))
                }
            }
        }
        
        if currentpos.y < 15 {    //if touches abyss
            self.plane.position.y += 150
            health -= 0.1 * CGFloat(1 - ((Double)(armor) * 0.05))
            
        }
    if health <= 0{      //gameOver Function call
            gameOver(currentTime)
        }
        
    }
    
    
    func enemyFunctions(currentTime: CFTimeInterval){
        
        for enemy in enemyArray{     //implements enemy bullet detection
            enemy.enemyAction(currentTime)
            if bulletArray.count != 0{
                for bullet in bulletArray{
                    let calculateBulletX = abs(enemy.position.x - bullet.position.x)
                    let calculateBulletY = abs(enemy.position.y - bullet.position.y)
                    let disX =  enemy.size.width / 2
                    let disY = enemy.size.height / 2
                    
                    if calculateBulletY < disY && calculateBulletX < disX {
                        if enemy.type != "target"{
                        bullet.removeFromParent()
                        bulletArray.removeAtIndex(bulletArray.indexOf(bullet)!)
                        enemy.hitPoints -= 1 + (Double(damage) * 0.25)
                        }
                    }
                }
            }
            if enemy.hitPoints <= 0{        //Checks if enemy is dead
                
                if enemy.getName() == "lazer" && enemy.shooting == true{
                    enemy.stopLazer()
                }
                
                enemyArray.removeAtIndex(enemyArray.indexOf(enemy)!)
                enemyValueCount += enemy.difficulty
                realScore += enemy.difficulty
                
                
                if enemy.type == "shooter"{
                    shooterSpacingArray.removeAtIndex(shooterSpacingArray.indexOf(enemy.lane)!)
                    laneCounter -= 1
                    if enemy.identity == "trapezoid"{
                        shooterSpacingArray.removeAtIndex(shooterSpacingArray.indexOf(enemy.lane + 1)!)
                        laneCounter -= 1
                    }
                }
                
                if enemy.type == "boss"{
                    bossReset()
                }
                
                let explode = SKAction(named: "Explode")!
                let remove = SKAction.removeFromParent()
                let sequence = SKAction.sequence([explode,remove])
                enemy.runAction(sequence)
            }
            if enemy.position.y <= -32{    //squares will erase if below -32
                enemyArray.removeAtIndex(enemyArray.indexOf(enemy)!)
                enemy.removeFromParent()
                enemyValueCount += enemy.difficulty
            }
        }
        
        
        if enemyBulletArray.count != 0{       // manages the enemy bullet movement
            for bullet in enemyBulletArray{
                bullet.bulletAction()
                if bullet.position.y <= -32{
                    enemyBulletArray.removeAtIndex(enemyBulletArray.indexOf(bullet)!)
                    bullet.removeFromParent()
                }
                
            }
        }
        
    }
    
    func checkDifficulty(currentTime: CFTimeInterval){  //loads the quene with the specific amount of enemies
        if(difficultyTimer == 0.0){
            difficultyTimer = currentTime
        }
        if bossGeneratorTimer == 0.0 {
            bossGeneratorTimer = currentTime
        }
        
        if currentTime - bossGeneratorTimer >= bossCounter{    //decides if to summon boss
            if bossAlert{
                let bossNowDecider = Int(arc4random_uniform(5) + 1)
                if bossNowDecider == 1{
                   let bossChooser = Int(arc4random_uniform(7) + 1)
                    addBoss(bossChooser)
                }
                else{
                    bossGeneratorTimer = 0.0
                }
            }
            else{
                bossAlert = true
                bossCounter = 10.0
                bossGeneratorTimer = 0.0
            }
        }
        
        if currentTime - difficultyTimer > 30.0 && totalDifficulty < 6{  //scales difficulty
            totalDifficulty += 1
            enemyValueCount += 2
            tempEnemyValueCount += 2
            difficultyTimer = 0.0
        }
        
        
        if enemyValueCount <= 4 || bossTrigger{        //if the total space of enemies is < 4, will make more enemies until hits exactly 0
        }
        else{
            
            repeat{
                let chooseEnemyValue = Int(arc4random_uniform(UInt32(totalDifficulty)) + 1)
                switch chooseEnemyValue{
                case 1:   //SQUARE
                    queneArray.append(1)
                    enemyValueCount -= 1
                case 2:   //TRIANGLE
                    enemyValueCount -= 2
                    if enemyValueCount < 0{
                        enemyValueCount += 2
                    }
                    else{
                        queneArray.append(2)
                    }
                case 3: //CIRCLE
                    enemyValueCount -= 2
                    if enemyValueCount < 0{
                        enemyValueCount += 2
                    }
                    else{
                        queneArray.append(3)
                    }
                case 4:  //TRAPEZOID
                    enemyValueCount -= 3
                    if enemyValueCount < 0 || laneCounter > 2{
                        enemyValueCount += 3
                    }
                    else{
                        queneArray.append(4)
                        laneCounter += 2
                    }
                case 5: //MISSILE
                    enemyValueCount -= 4
                    
                    if enemyValueCount < 0 || laneCounter > 4{
                        enemyValueCount += 4
                    }
                    else{
                        queneArray.append(5)
                        laneCounter += 1
                    }
                case 6: //LAZER
                    enemyValueCount -= 4
                    
                    if enemyValueCount < 0 || laneCounter > 4{
                        enemyValueCount += 4
                    }
                    else{
                        queneArray.append(6)
                        laneCounter += 1
                    }
                default:
                    break
                }

            }
            while enemyValueCount != 0
        }
        
    }
    
    
    func checkQuene(currentTime: CFTimeInterval){   //will deposit enemies at a consistent basis
        if queneTimer == 0.0{
            queneTimer = currentTime
        }
        else{
            if(currentTime - queneTimer > 0.7){
                if(queneArray.count > 0){
                    addNewEnemy(queneArray[0])
                    queneArray.removeFirst()
                    queneTimer = 0.0
                }
            }
        }
    }
    
    func shoot(currentTime: CFTimeInterval){
            let bulletWatch = currentTime - bulletTimer
            if bulletWatch >= 0.15 {
                addNewBullet()
                bulletTimer = currentTime
            }
    }
    
    func searchArray(arr: [Int], x: Int) -> Bool{
        if arr.count == 0{
            return false
        }
        else{
            for i in arr{
                if i == x{
                    return true
                }
            }
        }
        return false
    }
    
    
    
    func addNewBullet(){
        let bullet = Bullet()
        bullet.position = self.plane.position
        addChild(bullet)
        bulletArray.append(bullet)
    }
    
    func addNewEnemy(enemyType: Int){   //adds an enemy of a specific diffculty
        var enemyPos = Int(arc4random_uniform(6) + 1)
        var enemy: Enemy
        switch enemyType {
        case 1:                                     //SQUARE
            enemy = Square(lane: enemyPos)
            enemy.position = CGPoint(x: (Double)(enemyPos) * 53.33 - 26.665, y: 600)
            
        case 2:                                     //TRIANGLE
            enemy = Triangle(lane: enemyPos, scene: self)
            enemy.position = CGPoint(x: (Double)(enemyPos) * 53.33 - 26.655, y: 600)
            
        case 3:                                 //CIRCLE
            enemy = Circle(lane: enemyPos, scene: self)
            enemy.position = CGPoint(x: (Double)(enemyPos) * 53.33 - 26.655, y: 600)
            
        case 4:                                 //TRAPEZOID
            repeat{
                enemyPos = Int(arc4random_uniform(5) + 1)
            }
            while searchArray(shooterSpacingArray, x: enemyPos) || searchArray(shooterSpacingArray, x: (enemyPos + 1))
            shooterSpacingArray.append(enemyPos)
            shooterSpacingArray.append(enemyPos + 1)
            
            enemy = Trapezoid(lane: enemyPos, scene: self)
            enemy.position = CGPoint(x: (Double)(enemyPos) * 53.33, y: 500)
        case 5:                                     //MISSILE
            while searchArray(shooterSpacingArray, x: enemyPos){
                enemyPos = Int(arc4random_uniform(6) + 1)
            }
            shooterSpacingArray.append(enemyPos)
            
            enemy = Missile(lane: enemyPos,scene: self)
            enemy.position = CGPoint(x: (Double)(enemyPos) * 53.33 - 26.665, y: 500)
        
            
        case 6:                                     //LAZER
            while searchArray(shooterSpacingArray, x: enemyPos){
                enemyPos = Int(arc4random_uniform(6) + 1)
            }
            shooterSpacingArray.append(enemyPos)
            
            enemy = Lazer(lane: enemyPos,scene: self)
            enemy.position = CGPoint(x: (Double)(enemyPos) * 53.33 - 26.665, y: 500)
            
        default:
            enemy = Square(lane: enemyPos)
        }
        addChild(enemy)
        enemyArray.append(enemy)
    }
    
    func addBoss(bosnum: Int){
        bossTrigger = true
        var boss: Enemy
        for enemy in enemyArray{
            enemy.removeFromParent()
        }
        for ebullet in enemyBulletArray{
            ebullet.removeFromParent()
        }
        switch bosnum{
            case 1:
                boss = Boss1(lane: 0, scene: self)
                boss.position = CGPoint(x: 160, y: 500)
            case 2:
                boss = Boss2(lane: 0, scene: self)
                boss.position = CGPoint(x: 160, y: 500)
            case 3:
                boss = Boss3(lane: 0, scene: self)
                boss.position = CGPoint(x: 80, y: 500)
            case 4:
                boss = Boss4(lane: 0, scene: self)
                boss.position = CGPoint(x: 80, y: 500)
            case 5:
                boss = Boss5(lane: 0, scene: self)
                boss.position = CGPoint(x: 80, y: 500)
            case 6:
                boss = Boss6(lane: 0, scene: self)
                boss.position = CGPoint(x: 80, y: 500)
            case 7:
                boss = Boss7(lane: 0, scene: self)
                boss.position = CGPoint(x: 160, y: 500)
            default:
                boss = Boss1(lane: 0, scene: self)
                boss.position = CGPoint(x: 160, y: 500)
        }
        enemyBulletArray.removeAll()
        enemyArray.removeAll()
        queneArray.removeAll()
        shooterSpacingArray.removeAll()
        enemyValueCount = tempEnemyValueCount
        laneCounter = 0
        addChild(boss)
        enemyArray.append(boss)
    }
    
    
    func bossReset(){
        bossTrigger = false
        bossAlert = false
        bossCounter = 50.0
        bossGeneratorTimer = 0.0
    }
    
    
    func scrollWorld() {
        /* Scroll World */
        scrollLayer.position.y -= scrollSpeed * CGFloat(fixedDelta)
        
        /* Loop through scroll layer nodes */
        for ground in scrollLayer.children as! [SKSpriteNode] {
            
            /* Get ground node position, convert node position to scene space */
            let groundPosition = scrollLayer.convertPoint(ground.position, toNode: self)
            
            /* Check if ground sprite has left the scene */
            if groundPosition.y <= -ground.size.height / 2 + 5 {
                
                /* Reposition ground sprite to the second starting position */
                let newPosition = CGPointMake(groundPosition.x, (self.size.height / 2) + ground.size.height)
                
                /* Convert new node position back to scroll layer space */
                ground.position = self.convertPoint(newPosition, toNode: scrollLayer)
            }
        }
        
    }
    
    func manageDistance(currentTime: CFTimeInterval){
        if distanceTimer == 0.0{
            distanceTimer = currentTime
        }
        else if currentTime - distanceTimer >= 0.5{
            distance += 1
            distanceTimer = 0.0
        }

    }
    
    
    func gameOver(currentTime: CFTimeInterval) {
        let explode = SKAction(named: "Explode")!
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([explode,remove])
        self.plane.runAction(sequence)
        restart.state = .MSButtonNodeStateActive
        toMain.state = .MSButtonNodeStateActive
        pause.state = .MSButtonNodeStateHidden
        
        
        for enemy in enemyArray{
            enemy.removeFromParent()
        }
        for ebullet in enemyBulletArray{
            ebullet.removeFromParent()
        }
        for bullet in bulletArray{
            bullet.removeFromParent()
        }
        
        enemyBulletArray.removeAll()
        enemyArray.removeAll()
        queneArray.removeAll()
        shooterSpacingArray.removeAll()
        
        
        if UserState.sharedInstance.highScore < realScore{
            UserState.sharedInstance.highScore = realScore
        }
        
        scoreLabel.text = ""
        distanceLabel.text = ""
        finalScoreLabel.text = "Score: \(realScore) High: \(UserState.sharedInstance.highScore)"

        
        UserState.sharedInstance.coins += (Int)(realScore) + (Int)(distance / 10)
        
        distanceScoreLabel.text = "Distance: \(distance)m"
        
        state = .GameOver
    }

    
}
