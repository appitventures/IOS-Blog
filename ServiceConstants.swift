
import Foundation

enum Environment {
    
    case development
    case staging
    case production
    
    func baseURL() -> String {
        return "\(urlProtocol())://\(subdomain()).\(domain())\(route())"
    }
    
    func urlProtocol() -> String {
        switch self {
        case .production:
            return "https"
        default:
            return "http"
        }
    }
    
    func domain() -> String {
        switch self {
        case .development, .staging, .production:
            return "domain.com"
        }
    }
    
    func subdomain() -> String {
        switch self {
        case .development:
            return "dev.subdomain"
        case .staging:
            return "test.subdomain"
        case .production:
            return "prod.subdomain"
        }
    }
    
    func route() -> String {
        return "/api/v1"
    }
    
}

extension Environment {
    func host() -> String {
        return "\(self.subdomain()).\(self.domain())"
    }
}


// MARK:- APIs

#if DEBUG
let environment: Environment = Environment.development
#else
let environment: Environment = Environment.staging
#endif

let baseUrl = environment.baseURL()

struct Path {
    
    var registration: String { return "\(baseUrl)/registration" }
    
    var login: String { return "\(baseUrl)/login" }
    
    var forgotPassword: String { return "\(baseUrl)/forgotPassword" }
    
    var logout: String { return "\(baseUrl)/logout" }
    
    struct User {
        
        var getProfile: String { return "\(baseUrl)/profile" }
        
        var deleteUser: (Int) -> String = { userID in
            return "\(baseUrl)/profile/\(String(userID))"
        }
        
        struct Task {
            
            var getTasks: String { return "\(baseUrl)/tasks" }
            
            var getTaskDetail: (Int, Int) -> String = { userID, taskID in
                return "\(baseUrl)/profile/\(String(userID))/task/\(String(taskID))"
            }
            
        }
    }
}

/*
 
 baseUrl
 
 Path().login
 
 Path.User().getProfile
 
 Path.User().deleteUser(525)
 
 Path.User.Task().getTaskDetail(525, 2)
 
 */
