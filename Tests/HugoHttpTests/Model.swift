//
//  File.swift
//  
//
//  Created by tang on 2024/5/22.
//

import Foundation

struct AddUserReq:Codable{
    var age:Int64
    var name:String
}
struct UpdateUserReq:Codable{
    var id:Int64
    var age:Int64
    var name:String
}
struct User:Codable{
    var id:Int64
    var age:Int64
    var name:String
    var createdAt:Int64
    var updatedAt:Int64
}
