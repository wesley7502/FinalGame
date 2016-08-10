//
//  ViewController.swift
//  GameCenter
//
//  Created by Cyril Garcia on 8/10/16.
//  Copyright © 2016 ByCyril. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController, GKGameCenterControllerDelegate {
    
    var gameCenterAchievements = [String: GKAchievement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    //Don't worry about this, but you still need this.
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
        self.gameCenterAchievements.removeAll()
        
        
    }
    
    
    //This will save the users high score
    //You save the high score as
    
    func saveHighScore(identifier:String, score:Int) {
        
        /*
         self.saveHighScore("Your leaderboardID", score: playerScore)
         playerScore is your Int variable that holds the players score.
         
         */
        
        
        if GKLocalPlayer.localPlayer().authenticated {
            
            let scoreReporter = GKScore(leaderboardIdentifier: identifier)
            
            scoreReporter.value = Int64(score)
            
            let scoreArray:[GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: {
                error -> Void in
                
                if error != nil {
                    print("Error")
                } else {
                    
                    
                }
            })
        }
    }
    
    //This is will check for achievements
    func reportAchievement (identifier:String, percentComplete:Int) {
        //Report achievements like this
        //Create a function that will check if the user has reached the achievement.
        
        //self.reportAchievement("Your Achievement ID", percentComplete: 100
        //percentComplete is at 100 because it indicates that it is 100% complete.
        
        let achievement = GKAchievement(identifier: identifier)
        
        achievement.percentComplete = Double(percentComplete)
        achievement.showsCompletionBanner = true
        let achievementArray: [GKAchievement] = [achievement]
        
        GKAchievement.reportAchievements(achievementArray, withCompletionHandler: {
            
            error -> Void in
            
            if ( error != nil) {
                print(error)
            }
                
            else {
                
            }
            
        })
    }
    
    //This function will show GameCenter leaderboards and Achievements if you call this function.
    func showGameCenter() {
        
        let gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.gameCenterDelegate = self
        
        let vc:UIViewController = self.view!.window!.rootViewController!
        vc.presentViewController(gameCenterViewController, animated: true, completion:nil)
        
    }
    
    
    
}

