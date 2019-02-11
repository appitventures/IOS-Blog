

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
    
    func mockLoginUser(parameters: [String: Any], completion: @escaping (LoginModel?, Error?) -> ()) {
        
        // Add MockURLProtocol to protocol classes
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        // Mock response
        let sampleResponse =
        """
        {
            "http_status": 200,
            "message": "Login successful.",
            "auth_token": "$2y$10$MZ80wyGngTG3oXIiAw300O/qWlw7RZNNFfmGHNZQ8IOmtFvqUim6O"
        }
        """
        let mockJSONData = sampleResponse.data(using: .utf8)!
        // request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockJSONData)
        }
        // Request object
        let request = LoginAPI()
        let apiTaskLoader = APILoader(apiRequest: request, urlSession: urlSession)
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


