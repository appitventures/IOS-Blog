

import Foundation



struct LoginRequest: APITaskHandler {
    
    func makeRequest(from parameters: [String: Any]) -> Request {
        // prepare url
        let url = URL(string: Path().login)
        var urlRequest = URLRequest(url: url!)
        // set http method type
        urlRequest.httpMethod = "POST"
        // set body params
        set(parameters, urlRequest: &urlRequest)
        // prepares request (sets header params, any additional configurations)
        let request = BaseRequest(urlRequest: urlRequest)
        
        return request
    }
    
    func parseResponse(data: Data) throws -> LoginResponse {
        return try defaultParseResponse(data: data)
    }
}

struct UserDetailRequest: APITaskHandler {
    
    func makeRequest(from parameters: [String: Any]) -> Request {
        // url components
        var components = URLComponents(string: Path.User().getProfile)!
        var queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        components.queryItems = queryItems
        // url request
        let url = components.url
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        // prepares auth request (sets header params, any additional configurations)
        let request = AuthRequest(urlRequest: urlRequest)
        
        return request
    }
    
    func parseResponse(data: Data) throws -> UserDetailResponse {
        return try defaultParseResponse(data: data)
    }
}

