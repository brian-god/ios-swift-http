//
//  File.swift
//  
//
//  Created by tang on 2024/5/22.
//

import Foundation
enum NetworkError: Error {
    case invalidResponse
    case serverError(code:Int,message: String,reson:String)
    case parsingError
    case unauthorized
    case unknown
}
