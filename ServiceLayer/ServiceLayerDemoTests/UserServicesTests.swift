//
//  UserServicesTests.swift
//  ServiceLayerDemoTests
//
//  Created by Kiran on 12/12/18.
//  Copyright © 2018 Appit. All rights reserved.
//

import XCTest
@testable import ServiceLayerDemo

class LoginAPITests: XCTestCase {

    let request = LoginAPI()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test200Response() {
        let sampleResponse =
        """
        {
            "http_status": 200,
            "message": "Login successful.",
            "auth_token": "$2y$10$MZ80wyGngTG3oXIiAw300O/qWlw7RZNNFfmGHNZQ8IOmtFvqUim6O"
        }
        """
        let jsonData = sampleResponse.data(using: .utf8)!
        
        XCTAssertNoThrow(try request.parseResponse(data: jsonData))
        // or
        do {
            let response = try request.parseResponse(data: jsonData)
            XCTAssertEqual(response.authToken, "$2y$10$MZ80wyGngTG3oXIiAw300O/qWlw7RZNNFfmGHNZQ8IOmtFvqUim6O")
        } catch {
            XCTFail()
        }
    }

    func test203Response() {
        let sampleResponse =
        """
        {
            "http_status": 203,
            "message": "Invalid password."
        }
        """
        let jsonData = sampleResponse.data(using: .utf8)!
        
        XCTAssertThrowsError(try request.parseResponse(data: jsonData))
        
        // or
        
        do {
            let _ = try request.parseResponse(data: jsonData)
            XCTFail()
        } catch let error as ServiceError {
            XCTAssertEqual(error.httpStatus, 203)
            XCTAssertEqual(error.message, "Invalid password.")
        } catch {
            XCTFail()
        }
    }
    
    func test400Response() {
        let sampleResponse =
        """
        {
            "http_status": 400,
            "message": "Error"
        }
        """
        let jsonData = sampleResponse.data(using: .utf8)!
        
        do {
            let _ = try request.parseResponse(data: jsonData)
            XCTFail()
        } catch let error as ServiceError {
            XCTAssertEqual(error.httpStatus, 400)
            XCTAssertEqual(error.message, "Error")
        } catch {
            XCTFail()
        }
    }
    
    func testUnknownError() {
        let sampleResponse =
        """
        {
            "dummy text"
        }
        """
        let jsonData = sampleResponse.data(using: .utf8)!
        
        do {
            let _ = try request.parseResponse(data: jsonData)
            XCTFail()
        } catch let error as UnknownParseError {
            XCTAssertNotNil(error)
        } catch {
            XCTFail()
        }
        
    }
    
}


class UserDetailRequestTests: XCTestCase {
    
    let request = UserDetailAPI()
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testMakeRequest() {
        
        let urlRequest = request.makeRequest(from: ["id":525]).urlRequest
        
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertNil(urlRequest.httpBody)
        
        XCTAssertEqual(urlRequest.url?.absoluteString, "\(Path.User().getProfile)?id=525")
        XCTAssertNotNil(urlRequest.allHTTPHeaderFields)
        XCTAssertLessThanOrEqual(urlRequest.allHTTPHeaderFields!.count, 4)
    }
    
    
    func test203Response() {
        let sampleResponse =
        """
        {
            "http_status": 203,
            "message": "Invalid password."
        }
        """
        let jsonData = sampleResponse.data(using: .utf8)!
        
        do {
            let _ = try request.parseResponse(data: jsonData)
            XCTFail()
        } catch let error as ServiceError {
            XCTAssertEqual(error.httpStatus, 203)
            XCTAssertEqual(error.message, "Invalid password.")
        } catch {
            XCTFail()
        }
    }
    
    func test400Response() {
        let sampleResponse =
        """
        {
            "http_status": 400,
            "message": "Error"
        }
        """
        let jsonData = sampleResponse.data(using: .utf8)!
        
        do {
            let _ = try request.parseResponse(data: jsonData)
            XCTFail()
        } catch let error as ServiceError {
            XCTAssertEqual(error.httpStatus, 400)
            XCTAssertEqual(error.message, "Error")
        } catch {
            XCTFail()
        }
        
    }
    
    func testUnknownError() {
        let sampleResponse =
        """
        {
            "code": 400,
            "message": "unknown"
        }
        """
        let jsonData = sampleResponse.data(using: .utf8)!
        
        do {
            let _ = try request.parseResponse(data: jsonData)
            XCTFail()
        } catch let error as UnknownParseError {
            XCTAssertNotNil(error)
        } catch {
            XCTFail()
        }
        
    }
    
    
}
