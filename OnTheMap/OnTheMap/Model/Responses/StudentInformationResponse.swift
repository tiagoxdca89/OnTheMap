//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 17/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation

class StudentInformation: Codable {
    let last_name: String?
    let first_name: String?
    let location: String?
    let _has_password: Bool
    let key: String?
    let nickname: String?
    let _registered: Bool
    let linkedin_url: String?
    let _image_url: String?
}
