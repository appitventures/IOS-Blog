

import UIKit


final class SharedData {
    
    // MARK: - Singleton
    static func shared(userDefaults: UserDefaults = .standard) -> SharedData {
        
        if self.shared == nil {
            self.shared = SharedData(userDefaults: userDefaults)
        }
        return self.shared
    }
    
    private static var shared: SharedData!
    
    private init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    // MARK: - Properties
    
    // Constants
    private let authTokenKey = "AuthorizationToken"
    private let localAuthenticationKey = "localAuthenticationKey"
    
    let userDefaults: UserDefaults
    
    var token: String? = "2xoAeneanlaciniabibendumnullasedconsectetur."
  
    func clearSharedData() {
        
    }
    
    
}

