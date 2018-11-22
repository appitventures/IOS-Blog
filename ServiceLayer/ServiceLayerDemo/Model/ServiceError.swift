//
//  ServiceError.swift
//  ServiceLayerDemo
//
//  Created by Kiran on 09/11/18.
//  Copyright © 2018 Appit. All rights reserved.
//

import Foundation

struct ServiceError: Error, Codable {
    let httpStatus: Int
    let message: String
    let description: String?
}
