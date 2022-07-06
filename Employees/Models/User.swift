//
//  User.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.
//

import Foundation

struct UserResponse : Codable {
    
    var success : Bool
    var expires_at : String
    var request_token : String
}

struct UserModel : Codable {
    
    var username : String?
    var password : String?
}
