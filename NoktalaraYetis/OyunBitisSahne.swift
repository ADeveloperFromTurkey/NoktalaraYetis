//
//  OyunBitisSahne.swift
//  NoktalaraYetis
//
//  Created by Yusuf Erdem Ongun on 21.12.2025.
//

import SpriteKit

class OyunBitisSahne: SKScene {
    
    var userGameData: UserGameData!
    var lastGameMode: String
    let yenidenBaslaButon = SKSpriteNode(imageNamed: "Yeniden Başla")
    let anaMenuButon = SKSpriteNode(imageNamed: "Ana Menü")
    
    init(size: CGSize, UserGameData: UserGameData!, lastGameMode: String) {
        self.userGameData = UserGameData
        self.lastGameMode = lastGameMode
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "Arkaplan 2")
        background.zPosition = -1
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(background)
        
        let gameOverLabel = SKLabelNode(fontNamed: "Bion-Book")
        gameOverLabel.text = "- Oyun Bitti -"
        gameOverLabel.fontSize = 100
        gameOverLabel.fontColor = .black
        gameOverLabel.zPosition = 1
        gameOverLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.75)
        self.addChild(gameOverLabel)
        
        let sure = userGameData.Sure
        print(sure)
        
        if sure < userGameData.EnIyiSure {
            userGameData.EnIyiSure = sure
        }
        
        let scoreLabel = SKLabelNode(fontNamed: "Bion-Book")
        scoreLabel.text = "Süre : \((sure * 1000).rounded()) ms"
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = .black
        scoreLabel.zPosition = 3
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.65)
        self.addChild(scoreLabel)
        
        let bestScoreLabel = SKLabelNode(fontNamed: "Bion-Book")
        bestScoreLabel.text = " En İyi Süre : \((userGameData.EnIyiSure * 1000).rounded()) ms"
        bestScoreLabel.fontSize = 40
        bestScoreLabel.fontColor = .black
        bestScoreLabel.zPosition = 2
        bestScoreLabel.horizontalAlignmentMode = .center
        bestScoreLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.60)
        self.addChild(bestScoreLabel)
        
        yenidenBaslaButon.zPosition = 2
        yenidenBaslaButon.setScale(1.5)
        yenidenBaslaButon.position = CGPoint(x: self.size.width * 0.7, y: self.size.height * 0.35)
        self.addChild(yenidenBaslaButon)
        
        anaMenuButon.zPosition = 2
        anaMenuButon.setScale(1.5)
        anaMenuButon.position = CGPoint(x: self.size.width * 0.3, y: self.size.height * 0.35)
        self.addChild(anaMenuButon)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let dokunma = touch.location(in: self)
            
            if yenidenBaslaButon.contains(dokunma){
                
                let changSceneAction = SKAction.run(sahneDegistir)
                self.run(changSceneAction)
                
            }
            
            if anaMenuButon.contains(dokunma){
                
                let changSceneAction = SKAction.run(sahneDegistirAnaMenu)
                self.run(changSceneAction)
                
            }
            
        }
    }
    
    func sahneDegistir(){
        
        let sceneMoveTo = GameScene(size: self.size, gameMode: lastGameMode, userGameData: userGameData)
        sceneMoveTo.scaleMode = self.scaleMode
        let theTransition = SKTransition.fade(withDuration: 1.0)
        self.view!.presentScene(sceneMoveTo, transition: theTransition)
        
    }
    
    func sahneDegistirAnaMenu(){
        
        let sceneMoveTo = MainMenu(size: self.size, UserGameData: userGameData)
        sceneMoveTo.scaleMode = self.scaleMode
        let theTransition = SKTransition.fade(withDuration: 1.0)
        self.view!.presentScene(sceneMoveTo, transition: theTransition)
        
    }
    
}

        
