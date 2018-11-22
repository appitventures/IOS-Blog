

import Foundation

class UserServices {
    
    func loginUser(parameters: [String: Any], completion: @escaping (LoginResponse?, Error?) -> ()) {
        // Request object
        let request = LoginRequest()
        // API Object
        let apiTaskLoader = APITaskLoader(apiRequest: request)
        // Data request
        apiTaskLoader.loadAPIRequest(requestData: parameters) { (result, error) in
            completion(result, error)
        }
    }
    
    func getUserDetail(parameters: [String: Any], completion: @escaping (UserDetailResponse?, Error?) -> ()) {
        
        // Request object
        let request = UserDetailRequest()
        // API Object
        let apiRequestLoader = APITaskLoader(apiRequest: request)
        // Data request
        apiRequestLoader.loadAPIRequest(requestData: parameters) { (result, error) in
            completion(result, error)
        }
    }
}


