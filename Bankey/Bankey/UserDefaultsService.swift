//
//  UserDefaultsService.swift
//  Bankey
//
//  Created by Preoteasa Ioan-Silviu on 17.02.2023.
//

import Foundation

class UserDefaultsService {
    static let instance = UserDefaultsService()
    
    private enum UserDefaultsCases: String {
        case onboarded
    }
    
    public var onboarded: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultsCases.onboarded.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsCases.onboarded.rawValue)
        }
    }
}
