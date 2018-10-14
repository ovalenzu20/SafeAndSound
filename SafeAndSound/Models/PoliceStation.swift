//
//  PoliceStation.swift
//  SafeAndSound
//
//  Created by Omar Valenzuela on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import Foundation
import GoogleMaps

class PoliceStation{
    var name : String
    var location : CLLocation
    
    init(name : String, location : CLLocation) {
        self.name = name
        self.location = location
    }
}
