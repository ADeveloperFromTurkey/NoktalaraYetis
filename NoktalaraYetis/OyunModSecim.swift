//
//  OyunModSecim.swift
//  NoktalaraYetis
//
//  Created by Yusuf Erdem Ongun on 22.12.2025.
//

import SwiftUI
import SpriteKit

class OyunModSecim: SKScene {
    
    var userGameData: UserGameData
    let hiz = SKLabelNode(fontNamed: "Bion-Book")
    let onlu = SKLabelNode(fontNamed: "Bion-Book")
    let geri = SKSpriteNode(imageNamed: "Geri")
    
    init(size: CGSize, userGameData: UserGameData!){
        self.userGameData = userGameData
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        
        let arkaplan = SKSpriteNode(imageNamed: "Arkaplan")
        arkaplan.zPosition = -1
        arkaplan.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        arkaplan.size = self.size
        self.addChild(arkaplan)
        
        let girisYazi = SKLabelNode(fontNamed: "Bion-Book")
        girisYazi.text = "Mod Seçimi"
        girisYazi.fontSize = 110
        girisYazi.fontColor = .black
        girisYazi.zPosition = 3
        girisYazi.horizontalAlignmentMode = .center
        girisYazi.position = CGPoint(x: self.size.width * 0.53, y: self.size.height * 0.80)
        self.addChild(girisYazi)
        
        hiz.text = "Hız Modu(Tekli)"
        hiz.fontSize = 50
        hiz.fontColor = .black
        hiz.zPosition = 5
        hiz.horizontalAlignmentMode = .center
        hiz.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.60)
        self.addChild(hiz)
        
        onlu.text = "Onlu Mod"
        onlu.fontSize = 50
        onlu.fontColor = .black
        onlu.zPosition = 4
        onlu.horizontalAlignmentMode = .center
        onlu.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.55)
        self.addChild(onlu)
        
        geri.zPosition = 7
        geri.position = CGPoint(x: self.size.width * 0.25, y: self.size.height * 0.817)
        geri.setScale(1)
        self.addChild(geri)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if geri.contains(location){
                
                let sahneDegistir = SKAction.run(sahneDegistirAnaMenu)
                self.run(sahneDegistir)
                
            }
            
            if hiz.contains(location){
                
                let sahneDegistir = SKAction.run{self.sahneDegistirOyun(mod: "Hız")}
                self.run(sahneDegistir)
                
            }
            
            if onlu.contains(location){
                
                let sahneDegistir = SKAction.run{self.sahneDegistirOyun(mod: "10'lu")}
                self.run(sahneDegistir)
                
            }
            
            
        }
    }
    
    func sahneDegistirAnaMenu(){
        
        let sceneMoveTo = MainMenu(size: self.size, UserGameData: userGameData)
        sceneMoveTo.scaleMode = self.scaleMode
        let theTransition = SKTransition.fade(withDuration: 1.0)
        self.view!.presentScene(sceneMoveTo, transition: theTransition)
        
    }
    
    func sahneDegistirOyun(mod: String){
        
        let sceneMoveTo = GameScene(size: self.size, gameMode: mod, userGameData: userGameData)
        sceneMoveTo.scaleMode = self.scaleMode
        let theTransition = SKTransition.fade(withDuration: 1.0)
        self.view!.presentScene(sceneMoveTo, transition: theTransition)
        
    }
    
}
