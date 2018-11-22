

import Foundation


struct LoginResponse: Response {
    
    var httpStatus: Int
    var message: String
    var authToken: String
}

struct UserDetailResponse: Response {
    
    var httpStatus: Int
    var message: String
    var userID: String
    var userName: String
}






