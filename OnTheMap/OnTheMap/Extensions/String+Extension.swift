//
//  URL+Extension.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 20/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

extension String {
    func isValidURLString() -> Bool {
        if let url = NSURL(string: self) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
}
