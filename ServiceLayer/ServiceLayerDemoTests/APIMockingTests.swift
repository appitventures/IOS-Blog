
import XCTest
@testable import ServiceLayerDemo

class APIMockingTests: XCTestCase {

    var loader: APILoader<LoginAPI>!
    
    override func setUp() {
        super.setUp()
        
        let request = LoginAPI()
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        
        loader = APILoader(apiRequest: request, urlSession: urlSession)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        loader = nil
        super.tearDown()
    }

    func testLoginAPISuccess() {
        // input data
        let params = ["email": "test@gmail.com",
                      "password": 123456] as [String : Any]
        
        // mock response
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
            
//            XCTAssertNotNil(request.url?.absoluteString.contains("login"))
            return (HTTPURLResponse(), mockJSONData)
        }
        // load request
        let expectation = XCTestExpectation(description: "response")
        loader.loadAPIRequest(requestData: params) { result, error in
            
            if let result = result {
                
                XCTAssertEqual(result.authToken, "$2y$10$MZ80wyGngTG3oXIiAw300O/qWlw7RZNNFfmGHNZQ8IOmtFvqUim6O")
                expectation.fulfill()
            } else {
                XCTFail()
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    

//    func testNetworkError() {
//        // input data
//        let params = ["email": "test@gmail.com",
//                      "password": 123456] as [String : Any]
//
//        // mock response
//        let sampleResponse =
//        """
//        {
//            "http_status": 200,
//            "message": "Login successful.",
//            "auth_token": "$2y$10$MZ80wyGngTG3oXIiAw300O/qWlw7RZNNFfmGHNZQ8IOmtFvqUim6O"
//        }
//        """
//        let mockJSONData = sampleResponse.data(using: .utf8)!
//        // request handler
//        MockURLProtocol.requestHandler = { request in
//
//            return (HTTPURLResponse(), mockJSONData)
//        }
//        // load request
//        let expectation = XCTestExpectation(description: "response")
//
////        loader.isNetworkConnectionNone = true
//        loader.loadAPIRequest(requestData: params) { result, error in
//
//            if let result = result {
//                XCTFail()
//                expectation.fulfill()
//            } else if let error = error as? NetworkError {
//
//                XCTAssertTrue(true)
//                expectation.fulfill()
//            } else {
//                XCTFail()
//                expectation.fulfill()
//            }
//        }
//        wait(for: [expectation], timeout: 1)
//    }
//
}
