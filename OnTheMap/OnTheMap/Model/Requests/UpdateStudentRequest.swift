//
//  UpdateStudentRequest.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 17/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation

enum UpdateStudentRequest {
    
    case updateStudentLocation
    var path: String {
        return API.Student.UpdateLocation.path
    }
}
