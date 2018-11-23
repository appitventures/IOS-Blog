

import Foundation


struct LoginModel: Response {
    
    var httpStatus: Int
    var message: String
    var authToken: String
}

struct UserDetailModel: Response {
    
    var httpStatus: Int
    var message: String
    var userID: String
    var userName: String
}






