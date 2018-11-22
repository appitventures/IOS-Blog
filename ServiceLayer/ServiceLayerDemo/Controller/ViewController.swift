//
//  ViewController.swift
//  ServiceLayerDemo
//
//  Created by Kiran on 09/11/18.
//  Copyright © 2018 Appit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userBusiness = UserBusiness()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        userLogin()
        
//        userDetail()
    }
    
    
    func userLogin() {
        
        let params = ["user_name": "kiran",
                      "password": "test@123"]
        
        userBusiness.login(parameters: params) { (token, error) in
            if let token = token {
                print(token)
            } else if let error = error as? NetworkError {
                print(error.message)
            } else if let error = error as? ServiceError {
                print(error.httpStatus, error.httpStatus)
            } else if let error = error as? UnknownParseError {
                print(error.localizedDescription)
            }
        }
    }
    
    func userDetail() {
        
        userBusiness.userDetail(parameters: [:]) { (userDetail, error) in
            if let userDetail = userDetail {
                print(userDetail)
            } else if let error = error as? NetworkError {
                print(error.message)
            } else if let error = error as? ServiceError {
                print(error.httpStatus, error.httpStatus)
            }
        }
    }
    

}

