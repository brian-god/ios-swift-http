// The Swift Programming Language
// https://docs.swift.org/swift-book
import Alamofire
import Foundation
class NetworkManager{
    var baseURL:String = ""
    var token:String = ""
    var authPrefix:String = ""
    var authKey:String = "Authorization"
    var successCode:Int = 200
    static let shared = NetworkManager()
    private init() {}
    
    
    //get请求
    func get<T: Decodable>(_ endpoint: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil,isAuth:Bool = true, completion: @escaping (APIResult<T>) -> Void) {
        let reqHeaders = self.buildHeaders(headers: headers,auth: isAuth)
        AF.request(makeURL(endpoint), method: .get, parameters: parameters, headers: reqHeaders)
            .validate()
            .responseAPIResult(successCode:self.successCode,completionHandler: completion)
    }
    //post请求
    func post<T: Decodable,R: Encodable>(_ endpoint: String, parameters: R? = nil, headers: HTTPHeaders? = nil,isAuth:Bool = true, completion: @escaping (APIResult<T>) -> Void) {
        let reqHeaders = self.buildHeaders(headers: headers,auth: isAuth)
        AF.request(makeURL(endpoint), method: .post, parameters: parameters,encoder:JSONParameterEncoder.default, headers: reqHeaders)
            .validate()
            .responseAPIResult(successCode:self.successCode,completionHandler: completion)
    }
    //put请求
    func put<T: Decodable,R: Encodable>(_ endpoint: String, parameters: R? = nil, headers: HTTPHeaders? = nil,isAuth:Bool = true, completion: @escaping (APIResult<T>) -> Void) {
        let reqHeaders = self.buildHeaders(headers: headers,auth: isAuth)
        AF.request(makeURL(endpoint), method: .put, parameters: parameters,encoder:JSONParameterEncoder.default, headers: reqHeaders)
            .validate()
            .responseAPIResult(successCode:self.successCode,completionHandler: completion)
    }
    //delete请求
    func delete<T: Decodable>(_ endpoint: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil,isAuth:Bool = true, completion: @escaping (APIResult<T>) -> Void) {
        let reqHeaders = self.buildHeaders(headers: headers,auth: isAuth)
        AF.request(makeURL(endpoint), method: .delete, parameters: parameters, headers: reqHeaders)
            .validate()
            .responseAPIResult(successCode:self.successCode,completionHandler: completion)
    }
    //构建header
    public func buildHeaders(headers: HTTPHeaders?=nil,auth:Bool = false) -> HTTPHeaders{
        var req_header:HTTPHeaders = []
        if headers != nil{
            req_header = headers!;
        }
        if auth{
            var tk =  self.token
            if !authPrefix.isEmpty{
                tk = self.authPrefix + " " + self.token
            }
            req_header.add(name: self.authKey, value: tk)
        }
        return req_header
    }
    //获取地址
    private func makeURL(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
    
    // Alamofire请求方法
   func request<T: Codable>(endpoint: String, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil,isAuth:Bool = true, completion: @escaping (APIResult<T>) -> Void) {
       let reqHeaders = self.buildHeaders(headers: headers,auth: isAuth)
       AF.request(makeURL(endpoint), method: method, parameters: parameters,headers: reqHeaders).responseAPIResult(successCode:self.successCode,completionHandler: completion)
   }
}
