//
//  Report.swift
//  SafeAndSound
//
//  Created by Omar Valenzuela on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import Foundation

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
