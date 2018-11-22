
import Foundation

// MARK: - Errors
struct NetworkError: Error {
    let message: String
}

struct UnknownParseError: Error { }

// MARK: - APITaskHandler

protocol RequestHandler {
    
    associatedtype RequestDataType
    
    func makeRequest(from data: RequestDataType) -> Request
}

protocol ResponseHandler {
    
    associatedtype ResponseDataType
    
    func parseResponse(data: Data) throws -> ResponseDataType
}

typealias APITaskHandler = RequestHandler & ResponseHandler


// MARK: - Request

protocol Request {
    var urlRequest: URLRequest { get }
}

class BaseRequest: Request {
    
    private var request: URLRequest
    
    init(urlRequest: URLRequest) {
        self.request = urlRequest
    }
    
    var urlRequest: URLRequest {
        // header params
        self.request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request.setValue(AppHelper.getDeviceID(), forHTTPHeaderField: "DeviceId")
        self.request.setValue(AppHelper.getCurrentLanguage(), forHTTPHeaderField: "DeviceLanguage")
        
        return request
    }
}

class AuthRequest: BaseRequest {
    
    override var urlRequest: URLRequest {
        var request = super.urlRequest
        // set auth related headers
        let token = SharedData.shared().token!
        request.setValue(token, forHTTPHeaderField: "AuthToken")
        return request
    }
}

// MARK: -
extension RequestHandler {

    /// prepares httpbody
    func set(_ parameters: [String: Any], urlRequest: inout URLRequest) {
        // http body
        if parameters.count != 0 {
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
                urlRequest.httpBody = jsonData
            }
        }
    }
}


// MARK: - Response
protocol Response: Codable {
    var httpStatus: Int { set get }
}

extension ResponseHandler {
    /// generic response data parser
    func defaultParseResponse<T: Response>(data: Data) throws -> T {

        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

        if let body = try? jsonDecoder.decode(T.self, from: data), body.httpStatus == 200 {
            return body
        } else if let errorResponse = try? jsonDecoder.decode(ServiceError.self, from: data) {
            throw errorResponse
        } else {
            throw UnknownParseError()
        }
    }
}

