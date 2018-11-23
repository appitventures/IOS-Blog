//
//  UserBusiness.swift
//  ServiceLayerDemo
//
//  Created by Kiran on 09/11/18.
//  Copyright © 2018 Appit. All rights reserved.
//

import Foundation

class UserBusiness {
    
    private lazy var userServices = UserServices()
    
    // MARK: -
    
    func login(parameters: [String: Any], completion:@escaping ((_ token: String?, _ error: Error?) -> ()) ) {
        
        userServices.loginUser(parameters: parameters) { (response, error) in
            if let response = response {
                completion(response.authToken, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func userDetail(parameters: [String: Any],
               completion:@escaping ((_ userDetail: UserDetailModel?, _ error: Error?) -> ()) ) {
        
        userServices.getUserDetail(parameters: parameters) { (response, error) in
            completion(response, error)
        }
    }
    
}
