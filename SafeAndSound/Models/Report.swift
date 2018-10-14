//
//  Report.swift
//  SafeAndSound
//
//  Created by Omar Valenzuela on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

class Report {
    private var date   : Date
    private var year   : Int
    private var month  : Int
    private var day    : Int
    private var hour   : Int
    private var minute : Int
    
    init(date: Date) {
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: date)
        
        self.date = date
        self.year = dateTimeComponents.year!
        self.month = dateTimeComponents.month!
        self.day = dateTimeComponents.day!
        self.hour = dateTimeComponents.hour!
        self.minute = dateTimeComponents.minute!
    }
}

class CautiousReport : Report{
    var typeOfActivity : String
    var location : CLLocation
    var additionalInfo : String
    
    init(date: Date, typeOfActivity: String, location: CLLocation, additionalInfo: String) {
        self.typeOfActivity = typeOfActivity
        self.location = location
        self.additionalInfo = additionalInfo
        super.init(date: date)
    }
}

class EmergencyReport : Report{
    var nearbyUsers : [User]
    var nearbySafeSpots : [SafeSpot]
    var nearbyPoliceStation : [PoliceStation]
    
    init(date: Date, nearbyUsers : [User], nearbySafeSpots : [SafeSpot], nearbyPoliceStation : [PoliceStation]){
        self.nearbyUsers = nearbyUsers
        self.nearbySafeSpots = nearbySafeSpots
        self.nearbyPoliceStation = nearbyPoliceStation
        super.init(date: date)
    }
    
    func alertOtherUsers(withinRadius radius : Int){
        
    }
    
    func gatherNearbyUsers(withinRadius radius : Int){
        
    }
        
}
