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
}

class LocationManager: NSObject {
    
    
    func getLocation(forPlaceCalled name: String,
                     completion: @escaping(CLLocation?, ErrorType?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil, .geocodeAddressStringError)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil,.placemarkIsNil)
                return
            }
            
            guard let location = placemark.location else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil, .placeMarkLocationNil)
                return
            }
            completion(location, nil)
        }
    }
}
