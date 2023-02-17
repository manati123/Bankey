//
//  UserDefaultsService.swift
//  Bankey
//
//  Created by Preoteasa Ioan-Silviu on 17.02.2023.
//

import Foundation

class UserDefaultsService {
    static let instance = UserDefaultsService()
    
    enum UserDefaultsCases: String {
        case onboarded
    }
    
    public func storeUserOnboardingStatus() {
        UserDefaults.standard.set(true, forKey: UserDefaultsCases.onboarded.rawValue)
    }
    
    public func isUserOnboarded() -> Bool { UserDefaults.standard.bool(forKey: UserDefaultsCases.onboarded.rawValue) }
}
