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
        
        
        let arkaplan = SKSpriteNode(imageNamed: "arkaplan")
        arkaplan.zPosition = -1
        arkaplan.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        arkaplan.size = self.size
        self.addChild(arkaplan)
        
        let girisYazi = SKLabelNode(fontNamed: "Bion-Book")
        girisYazi.text = "Mod Seçimi"
        girisYazi.fontSize = 70
        girisYazi.fontColor = .black
        girisYazi.zPosition = 3
        girisYazi.horizontalAlignmentMode = .center
        girisYazi.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.80)
        self.addChild(girisYazi)
        
        hiz.text = "hız Modu(Tekli)"
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
        onlu.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.50)
        self.addChild(onlu)
        
        geri.zPosition = 7
        geri.position = CGPoint(x: self.size.width * 0.25, y: self.size.height * 0.85)
        geri.size = self.size
        self.addChild(geri)
        
    }
    
}
