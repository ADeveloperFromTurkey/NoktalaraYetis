//
//  GameScene.swift
//  NoktalaraYetis
//
//  Created by Yusuf Erdem Ongun on 30.10.2025.
//

import SpriteKit
import GameplayKit

class NoktaBilgi: SKNode {
    var konum: CGPoint? // Konum
    var numara: Int // No.
    var baslangicSure: TimeInterval?

    init(konum: CGPoint?, numara: Int, baslangicSure: TimeInterval?) {
        self.konum = konum
        self.numara = numara
        self.baslangicSure = baslangicSure
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum GameState {
    case starting
    case playing
    case gameOver
}

class GameScene: SKScene {
    
    
    let hedef = SKSpriteNode(imageNamed: "Hedef")
    let isaret = SKSpriteNode(imageNamed: "Ok")
    let puanYazi = SKLabelNode(fontNamed: "Bion-Book")
    let baslaYazi = SKLabelNode(fontNamed: "Bion-Book")
    var userGameData: UserGameData!
    var gameMode: String
    var nokta = NoktaBilgi(konum: nil, numara: 0, baslangicSure: nil)
    var bitis = 0.00000
    var gameArea: CGRect
    var oyunDurum = GameState.starting
    var sureler: [Double] = []
    
    init(size: CGSize, gameMode: String, userGameData: UserGameData) {
        
        // 2. Set properties AFTER
        let maxAspectRatio: CGFloat = 16.0 / 9.0
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        self.gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        self.gameMode = gameMode
        self.userGameData = userGameData
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        
        let arkaplan = SKSpriteNode(imageNamed: "Arkaplan") // Arkaplan Kodu
        arkaplan.size = self.size
        arkaplan.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        arkaplan.zPosition = 0
        
        self.addChild(arkaplan)
        
        puanYazi.text = " Süre: --"
        puanYazi.fontSize = 50
        puanYazi.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        puanYazi.position = CGPoint(x: self.size.width * 0.2, y: self.size.height * 1.2)
        puanYazi.zPosition = 100
        
        baslaYazi.text = "Başlamak için dokun!"
        baslaYazi.fontSize = 70
        baslaYazi.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        baslaYazi.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        baslaYazi.zPosition = 100
        baslaYazi.alpha = 0
        
        self.addChild(baslaYazi)
        self.addChild(puanYazi)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
        baslaYazi.run(fadeInAction)
        let puanGelme = SKAction.moveTo(y: self.size.height * 0.9, duration: 0.7)
        puanYazi.run(puanGelme)
        
        
        
    }
    
    func noktaOlustur(ox: CGFloat, oy: CGFloat) { // Nokta Oluştur
        
        guard hedef.parent != nil else { //İlk nokta
            nokta = NoktaBilgi(konum: nil, numara: 1, baslangicSure: nil)
            
            let konum = mesafeliKonumBelirle(x: ox,y: oy)
            isaret.zPosition = -100
            isaret.position = konum
            hedef.setScale(1)
            hedef.position = konum
            hedef.zPosition = 50
            hedef.name = "Hedef"
            nokta.konum = konum
            
            print("Hedef no:",nokta.numara," yeni konum:",nokta.konum!)
            
            if oyunDurum == GameState.playing {
                let wait = SKAction.wait(forDuration: 1.5)
                let add = SKAction.run{self.addChild(self.hedef)}
                let baslat = SKAction.run{self.nokta.baslangicSure = Date().timeIntervalSince1970}
                let sequence = SKAction.sequence([wait, baslat, add])
                self.run(sequence)
            }
            
            return
        }
        
        bitis = Date().timeIntervalSince1970
        isaret.removeFromParent()
        
        let sure = bitis - nokta.baslangicSure!
        print(sure)
        let yeniKonum = mesafeliKonumBelirle(x: ox, y: oy)
        let eskiKonum = CGPoint(x: ox, y: oy)
        let hedefAnimasyon = SKAction.move(to: yeniKonum, duration: 0.1)
        
        sureler.append(sure)
        print(sureler)
        
        puanYazi.text = " Süre: \((sure * 1000).rounded()) ms"
        
        isaret.zPosition = 10
        isaret.position = araKonum(eski: eskiKonum, yeni: yeniKonum)
        isaret.zRotation = konumYonBul(eski: eskiKonum, yeni: yeniKonum)
        isaret.setScale(boyBelirleOk(mesafe: mesafeBul(k1: eskiKonum, k2: yeniKonum)))
        
        nokta.baslangicSure = Date().timeIntervalSince1970
        nokta.konum = yeniKonum
        nokta.numara += 1
        
        if(gameMode == "10'lu" && nokta.numara == 11) {
            oyunBitir()
            return
        }
        if(gameMode == "Hız" && nokta.numara == 2) {
            oyunBitir()
            return
        }
        
        if oyunDurum == GameState.playing {
            hedef.run(hedefAnimasyon)
            self.addChild(isaret)
        }
        
        print("Süre:",sure)
        print("Hedef no:",nokta.numara," yeni konum:",nokta.konum!," Mesafe:", mesafeBul(k1: eskiKonum, k2: yeniKonum)) // Rapor
        
        
    }
    func boyBelirleOk(mesafe: Int) -> CGFloat{
        if mesafe < 400{
            return 0.5
        } else if mesafe < 700{
            return 1.0
        } else {
            return 1.2
        }
    }
    
    func oyunBitir(){
        
        oyunDurum = GameState.gameOver
        
        userGameData.Sure = sureHesapla(sureler)
        print(sureHesapla(sureler))
        print(userGameData.Sure)
        
        self.removeAllActions()
        self.enumerateChildNodes(withName: "Hedef"){
            hedef, stop in
            
            hedef.removeAllActions()
            
        }
        
        let changSceneAction = SKAction.run(sahneDegistir)
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let changeSceneSequence = SKAction.sequence([waitToChangeScene, changSceneAction])
        self.run(changeSceneSequence)
        
    }
    
    func sureHesapla(_ sureler: [Double]) -> Double {
        var toplam = 0.0000000000000000
        for i in 0...(sureler.count - 1) {
            toplam += sureler[i]
        }
        
        let ortSure = toplam / Double(sureler.count)
        print(ortSure)
        
        return ortSure
        
    }
    
    func sahneDegistir(){
        let sceneMoveTo = OyunBitisSahne(size: self.size, UserGameData: userGameData, lastGameMode: gameMode)
        sceneMoveTo.scaleMode = self.scaleMode
        let theTransition = SKTransition.fade(withDuration: 1.0)
        self.view!.presentScene(sceneMoveTo, transition: theTransition)
    }
    
    func araKonum(eski: CGPoint, yeni: CGPoint) -> CGPoint{
        return(CGPoint(x: (eski.x + yeni.x) / 2, y: (eski.y + yeni.y) / 2))
    }
    func konumYonBul(eski: CGPoint, yeni: CGPoint) -> Double{
        return atan2(Double(yeni.y - eski.y), Double(yeni.x - eski.x))
    }
    
    func mesafeBul(k1: CGPoint, k2: CGPoint) -> Int { // Mesafe işle
        let x1 = k1.x
        let y1 = k1.y
        let x2 = k2.x
        let y2 = k2.y
        
        let dx = abs(x2 - x1)
        let dy = abs(y2 - y1)
        
        let mesafe = sqrt(dx * dx + dy * dy) //Matematik formülü
        
        return Int(mesafe)
    }

    
    func mesafeliKonumBelirle(x: CGFloat, y: CGFloat) -> CGPoint{
        
        let en = hedef.size.width
        let boy = hedef.size.height //En ve Boy
        
        let eskiKonum = CGPoint(x: x, y: y)
        var yeniKonum = eskiKonum
        var yeniX = yeniKonum.x
        var yeniY = yeniKonum.y
        
        let sagkenar = CGRectGetMaxX(gameArea)
        let solkenar = CGRectGetMinX(gameArea)
        let ustkenar = CGRectGetMaxY(gameArea)
        let altkenar = CGRectGetMinY(gameArea)
        
        while (mesafeBul(k1: yeniKonum, k2: eskiKonum) < 300 || yeniKonum.x < solkenar + en || yeniKonum.x > sagkenar - en || yeniKonum.y < altkenar + boy || yeniKonum.y > ustkenar - boy){
            let x = CGFloat(Int.random(in: 0..<Int(self.size.width)))
            let y = CGFloat(Int.random(in: 0..<Int(self.size.height)))
            yeniX = x
            yeniY = y
            yeniKonum = CGPoint(x: yeniX, y: yeniY)
        }
        return yeniKonum
    }
    
    func startGame(dokunmaX: CGFloat, dokunmaY: CGFloat){
        oyunDurum = GameState.playing
        let kaybolmaAnimasyonu = SKAction.moveTo(y: 0 - 200, duration: 0.7)
        let sil = SKAction.removeFromParent()
        let sequence = SKAction.sequence([kaybolmaAnimasyonu, sil])
        baslaYazi.run(sequence)
        noktaOlustur(ox: dokunmaX, oy: dokunmaY)
    }
    
    
    func konumBelirle() -> CGPoint{
        
        let en = hedef.size.width
        let boy = hedef.size.height //En ve Boy
        
        let sagkenar = CGRectGetMaxX(gameArea)
        let solkenar = CGRectGetMinX(gameArea)
        let ustkenar = CGRectGetMaxY(gameArea)
        let altkenar = CGRectGetMinY(gameArea)
        
        var yeniNokta = CGPoint(x: 0, y: 0) // Kabul edilmeyip döngüye girecek bir değer
        while yeniNokta.x < solkenar + en || yeniNokta.x > sagkenar - en || yeniNokta.y < altkenar + boy || yeniNokta.y > ustkenar - boy{
            let yeniX = CGFloat(Int.random(in: 0..<Int(self.size.width)))
            let yeniY = CGFloat(Int.random(in: 0..<Int(self.size.height)))
            yeniNokta = CGPoint(x: yeniX, y: yeniY)
        }
        return yeniNokta
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if hedef.contains(location) && oyunDurum == GameState.playing{
                noktaOlustur(ox: nokta.konum!.x, oy: nokta.konum!.y)
            }
            
            if baslaYazi.contains(location) && oyunDurum == GameState.starting{
                startGame(dokunmaX: location.x, dokunmaY: location.y)
            }
            
        }
    }
}
