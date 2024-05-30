//
//  File.swift
//  
//
//  Created by tang on 2024/4/12.
//

import Foundation


struct APIResponse<Value: Decodable>: Decodable {
    let code: Int
    let msg: String
    let reason: String
    let data: Value
}

struct DefResponse: Decodable {
    let code: Int
    let msg: String
    let reason: String
}
public enum APIResult<Value> {
    case success(Value)
    case failure(Int, String, String)
}
// 后台返回的打他为{}的时候使用
public struct NullData:Codable{
    
}
