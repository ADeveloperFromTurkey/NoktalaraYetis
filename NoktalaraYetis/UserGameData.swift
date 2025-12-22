//
//  UserGameData.swift
//  NoktalaraYetis
//
//  Created by Yusuf Erdem Ongun on 12.11.2025.
//

import SwiftUI
import Combine

class UserGameData: ObservableObject {
    
    @Published var Sure: Double {
        didSet {
            UserDefaults.standard.set(Sure, forKey: "Sure")
            print("Süre Kaydedildi")
        }
    }
    @Published var EnIyiSure: Double {
        didSet {
            UserDefaults.standard.set(EnIyiSure, forKey: "EnIyiSure")
            print("En İyi Süre Kaydedildi")
        }
    }
    
    init() {
        self.Sure = UserDefaults.standard.double(forKey: "Sure")
        self.EnIyiSure = UserDefaults.standard.double(forKey: "EnIyiSure")
        if self.EnIyiSure == 0.0 {
            EnIyiSure = 1000000000.0
        }
    }
    
}
