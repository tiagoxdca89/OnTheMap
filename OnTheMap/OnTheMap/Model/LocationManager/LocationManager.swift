//
//  LocationManager.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 19/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import CoreLocation

enum ErrorType: Error {
    case geocodeAddressStringError
    case placemarkIsNil
    case placeMarkLocationNil
    
    var description: String {
        switch self {
        case .geocodeAddressStringError:
            return "Error attempting convert location to coordinates"
        case .placemarkIsNil:
            return "PlaceMark is empty"
        case .placeMarkLocationNil:
            return "Placemark location is empty"
        }
    }
}

class LocationManager: NSObject {
    
    
    func getLocation(forPlaceCalled name: String,
                     completion: @escaping(CLLocation?, ErrorType?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { placemarks, error in
            
            guard error == nil else {
                completion(nil, .geocodeAddressStringError)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                completion(nil,.placemarkIsNil)
                return
            }
            
            guard let location = placemark.location else {
                completion(nil, .placeMarkLocationNil)
                return
            }
            completion(location, nil)
        }
    }
}
