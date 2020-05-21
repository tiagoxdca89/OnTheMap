//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 17/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation

class StudentInformationResponse: Codable {
    let last_name: String?
    let first_name: String?
    let location: String?
    let _has_password: Bool
    let key: String
    "nickname": "John",
    "employer_sharing": true,
    "_memberships": [],
    "zendesk_id": null,
    "_registered": true,
    "linkedin_url": null,
    "_google_id": null,
    "_image_url": "//robohash.org/udacity-3903878747.png"
}
