//
//  GameViewController.swift
//  NoktalaraYetis
//
//  Created by Yusuf Erdem Ongun on 30.10.2025.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
                
                let scene = GameScene(size: CGSize(width: 1536, height: 2048), gameMode: "10'lu", userGameData: appDelegate.appUserData)
                scene.scaleMode = SKSceneScaleMode.aspectFill
                
                // Present the scene
                view.presentScene(scene)
            } else {
            fatalError("AppDelegate'e veya UserData'ya erişilemiyor!")
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
