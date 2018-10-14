//
//  SafeSpot.swift
//  SafeAndSound
//
//  Created by Omar Valenzuela on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import Foundation
import GoogleMaps

class SafeSpot{
    var location : CLLocation
    var name : String
    
    init(location : CLLocation,  name : String) {
        self.location = location
        self.name = name
    }
}
