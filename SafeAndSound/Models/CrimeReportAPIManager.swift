//
//  CrimeReportAPIManager.swift
//  SafeAndSound
//
//  Created by Omar Valenzuela on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import Foundation

class CrimeReportAPIManager{
    
    var session : URLSession
    let baseURL = "https://data.lacity.org/resource/7fvc-faax.json"
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    func currentCriminalLocations(completion: @escaping ([CrimeReport]?, Error?) -> ()){
        let url = URL(string: baseURL)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [Any]
                let crimeReports = CrimeReport.crimeReports(dictionaries: dataDictionary)
                
                completion(crimeReports, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
}

