//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 17/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation

enum LoginRequest {
    
    case login
    var path: String {
        return API.Login.path
    }
}

struct LoginBody: Codable {
    let udacity: Credentials
}

struct Credentials: Codable {
    let username: String
    let password: String
}
