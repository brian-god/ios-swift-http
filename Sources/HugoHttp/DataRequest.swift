//
//  File.swift
//  
//
//  Created by tang on 2024/5/22.
//

import Foundation
import Alamofire
//扩展请求
extension DataRequest {
    @discardableResult
    func responseAPIResult<Value: Decodable>(queue: DispatchQueue? = nil,successCode:Int, completionHandler: @escaping (APIResult<Value>) -> Void) -> Self {
        return response(queue: queue ?? .main, responseSerializer: DataResponseSerializer()) { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let defResponse = try JSONDecoder().decode(DefResponse.self, from: data)
                    if defResponse.code == successCode {
                        let decodeResponse = try JSONDecoder().decode(APIResponse<Value>.self, from: data)
                        completionHandler(.success(decodeResponse.data))
                    } else {
                        completionHandler(.failure(defResponse.code, defResponse.msg, defResponse.reason))
                    }
                } catch {
                    completionHandler(.failure(500, "Failed to decode response", error.localizedDescription))
                }
            case .failure(let error):
                completionHandler(.failure(500, "Request failed", error.localizedDescription))
            }
        }
    }
}
