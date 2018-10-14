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
    var lat : CLLocationDegrees
    var long : CLLocationDegrees
    var name : String
    
    init(lat : CLLocationDegrees, long : CLLocationDegrees,  name : String) {
        self.lat = lat
        self.long = long
        self.name = name
    }
}
