//
//  MainMenu.swift
//  NoktalaraYetis
//
//  Created by Yusuf Erdem Ongun on 22.12.2025.
//

import SwiftUI
import SpriteKit


class MainMenu: SKScene {
    
    var userGameData: UserGameData
    
    init(size: CGSize, UserGameData: UserGameData!) {
        self.userGameData = UserGameData
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let baslaButonu = SKSpriteNode(imageNamed: "Başla")
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "Arkaplan 2")
        background.zPosition = -1
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(background)
        
        baslaButonu.zPosition = 10
        baslaButonu.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.4)
        self.addChild(baslaButonu)
        
        let girisYazi = SKLabelNode(fontNamed: "Bion-Book")
        girisYazi.text = "Noktaları Yakala!"
        girisYazi.fontSize = 70
        girisYazi.fontColor = .black
        girisYazi.zPosition = 3
        girisYazi.horizontalAlignmentMode = .center
        girisYazi.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.65)
        self.addChild(girisYazi)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if baslaButonu.contains(location){
                let changSceneAction = SKAction.run(sahneDegistir)
                self.run(changSceneAction)
            }
        }
        
    }
    
    func sahneDegistir(){
        
        let sceneMoveTo = OyunModSecim(size: self.size, userGameData: userGameData)
        sceneMoveTo.scaleMode = self.scaleMode
        let theTransition = SKTransition.fade(withDuration: 1.0)
        self.view!.presentScene(sceneMoveTo, transition: theTransition)
        
    }
    
}
