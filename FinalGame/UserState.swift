//
//  UserState.swift
//  FinalGame
//
//  Created by Tsai Family on 8/2/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation

class UserState {
    class var sharedInstance : UserState {
        struct Static {
            static let instance : UserState = UserState()
        }
        return Static.instance
    }
    
    var highScore: Int = NSUserDefaults.standardUserDefaults().integerForKey("myHighScore") ?? 0 {
        didSet {
            NSUserDefaults.standardUserDefaults().setInteger(highScore, forKey:"myHighScore")
            // Saves to disk immediately, otherwise it will save when it has time
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var armor: Int = NSUserDefaults.standardUserDefaults().integerForKey("myArmor") ?? 0 {
        didSet {
            NSUserDefaults.standardUserDefaults().setInteger(armor, forKey:"myArmor")
            // Saves to disk immediately, otherwise it will save when it has time
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var damage: Int = NSUserDefaults.standardUserDefaults().integerForKey("myDamage") ?? 0 {
        didSet {
            NSUserDefaults.standardUserDefaults().setInteger(damage, forKey:"myDamage")
            // Saves to disk immediately, otherwise it will save when it has time
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var coins: Int = NSUserDefaults.standardUserDefaults().integerForKey("myCoins") ?? 0 {
        didSet {
            NSUserDefaults.standardUserDefaults().setInteger(coins, forKey:"myCoins")
            // Saves to disk immediately, otherwise it will save when it has time
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    
    var didTutorial: Bool = NSUserDefaults.standardUserDefaults().boolForKey("myDamage") ?? false {
        didSet {
            NSUserDefaults.standardUserDefaults().setBool(didTutorial, forKey:"didTutorial")
            // Saves to disk immediately, otherwise it will save when it has time
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    
}


