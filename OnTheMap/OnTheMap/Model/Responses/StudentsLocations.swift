//
//  StudentsLocations.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 17/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation

struct StudentsLocations: Codable {
    let results: [StudentLocation]
    
    static func getFakeStudentInformation() -> StudentLocation {
        return StudentLocation(createdAt: "2015-02-24T22:27:14.456Z",
                                  firstName: "Joao",
                                  lastName: "Almeida",
                                  latitude: 41.4444300,
                                  longitude: -8.2961900,
                                  mapString: "Tarpon Springs, FL",
                                  mediaURL: "www.linkedin.com/in/jessicauelmen/en",
                                  objectId: "kj18GEaWD8",
                                  uniqueKey: "872458750",
                                  updatedAt: "2015-03-09T22:07:09.593Z")
    }
}

struct StudentLocation: Codable {
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
}
