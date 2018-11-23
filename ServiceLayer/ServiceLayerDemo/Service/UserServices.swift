

import Foundation

class UserServices {
    
    func loginUser(parameters: [String: Any], completion: @escaping (LoginModel?, Error?) -> ()) {
        // api
        let api = LoginAPI()
        // api loader
        let apiTaskLoader = APILoader(apiRequest: api)
        
        apiTaskLoader.loadAPIRequest(requestData: parameters) { (result, error) in
            completion(result, error)
        }
    }
    
    func getUserDetail(parameters: [String: Any], completion: @escaping (UserDetailModel?, Error?) -> ()) {
        // api
        let api = UserDetailAPI()
        // api loader
        let apiRequestLoader = APILoader(apiRequest: api)
        
        apiRequestLoader.loadAPIRequest(requestData: parameters) { (result, error) in
            completion(result, error)
        }
    }
}


