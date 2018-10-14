//
//  CrimeReport.swift
//  SafeAndSound
//
//  Created by Omar Valenzuela on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import Foundation
import CoreLocation

class CrimeReport{
    var longitude : CLLocationDegrees
    var latitude : CLLocationDegrees
    var type : String
    
    init(dictionary : [String : Any]) {
        let locations = dictionary["location_1"] as! [String : Any]
        let coordinates = locations["coordinates"] as! [CLLocationDegrees]

//        var date = dictionary["date_occ"] as! String
//
//        print(date.prefix(4))
        self.longitude = coordinates[1]
        self.latitude = coordinates[0]
        self.type = dictionary["crm_cd_desc"] as! String
        
    }
    
    class func crimeReports(dictionaries : [Any]) -> [CrimeReport]{
        var crimeReports : [CrimeReport] = []
        
        for item in dictionaries{
            var anyItem = item as! [String : Any]
            let date = anyItem["date_occ"] as! String
            
            if date.prefix(4) == "2018"{
                crimeReports.append(CrimeReport(dictionary: item as! [String : Any]))

            }
        }
        return crimeReports
    }
    
}
