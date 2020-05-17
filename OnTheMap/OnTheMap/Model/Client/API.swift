//
//  API.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 17/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation

struct API {
    
    struct Login {
        static let path = "https://onthemap-api.udacity.com/v1/session"
    }
    
    struct SessionDelete {
        static let path = "https://onthemap-api.udacity.com/v1/session"
    }
    
    struct Student {
        struct Locations {
            static let path = "https://onthemap-api.udacity.com/v1/StudentLocation"
        }
        struct PostLocation {
            static let path = "https://onthemap-api.udacity.com/v1/StudentLocation"
        }
        struct UpdateLocation {
            static let path = "https://onthemap-api.udacity.com/v1/StudentLocation/%@"
        }
        struct Information {
            static let path = "https://onthemap-api.udacity.com/v1/users/%@"
        }
    }
    
}
