//
//  MapViewController.swift
//  SafeAndSound
//
//  Created by Omar Valenzuela on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate {
    let locationMgr = CLLocationManager()
    var lattitude : CLLocationDegrees = 0
    var longitude : CLLocationDegrees = 0
    var currentLocation : CLLocation!
    var crimeReports : [CrimeReport] = [] {
        didSet {
            displayCrimeReports()
        }
    }
    
    
    @IBOutlet fileprivate weak var mapView   : GMSMapView!
    @IBOutlet weak var reportContainerView   : UIView!
    @IBOutlet weak var reportImageView: UIImageView!
    @IBOutlet weak var recentReportsContainerView: UIView!
    
    
    
    
    fileprivate func setupViews() {
        reportContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, height: (view.frame.height / 4) * 3)
        
        reportImageView.anchor(top: reportContainerView.topAnchor, leading: reportContainerView.leadingAnchor, bottom: nil, trailing: nil, padding: Padding(top: 22, left: 16), width: (reportContainerView.frame.width / 2) - 16, height: (reportContainerView.frame.width / 2) - 16)
        
        reportImageView.setProperties(bgColor: nil, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: 2, borderColor: .white, borderWidth: 4)
    
        recentReportsContainerView.anchor(top: reportImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: Padding(top: 16, left: 16), height: 30)
        
        recentReportsContainerView.setProperties(bgColor: .white, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: 2, borderColor: nil, borderWidth: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCriminalLocations()
        
        setupViews()
        lattitude = 37.785834
        longitude = -122.406417
        let camera = GMSCameraPosition.camera(withLatitude: 37.785834, longitude: -122.406417, zoom: 2)
        mapView.camera = camera
        
        showEmergencyMarker(position: camera.target, emergencyTitle: "SD HACKS ALMOST OVER")
        drawCircle(lat: lattitude ,long: longitude, opacity: 0.15, radius: 1000)
        
        let newPosition = CLLocationCoordinate2D(latitude: lattitude - 0.05, longitude: longitude - 0.05 )
        showEmergencyMarker(position: newPosition, emergencyTitle: "SD HACKS 2018")
        
        drawCircle(lat: newPosition.latitude, long: newPosition.longitude, opacity: 0.15, radius: 1000)
       

    }
    
    func fetchCriminalLocations(){
        CrimeReportAPIManager().currentCriminalLocations { (crimeReports : [CrimeReport]?, error : Error?) in
            if let crimeReports = crimeReports{
                self.crimeReports = crimeReports
            }
        }
    }
   
    
    func displayCrimeReports(){
        
        for event in crimeReports{
            let long : CLLocationDegrees = event.latitude - 0.001
            let lat : CLLocationDegrees = event.longitude
            let pos = CLLocationCoordinate2D(latitude: lat, longitude: long)
            showEmergencyMarker(position: pos, emergencyTitle: event.type)
        }
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    func showEmergencyMarker(position: CLLocationCoordinate2D, emergencyTitle: String){
        let marker      = GMSMarker()
//        print(position)
        marker.position = position
        marker.title    = emergencyTitle
        let image       = UIImage(named: "AlertPin-10")
        marker.icon     = resizeImage(image: image!, newWidth: 40)
        marker.map      = mapView
    }
    
    
    func showCautiousMarker(position: CLLocationCoordinate2D, cautiousTitle: String, cautiousSnippet: String){
        let marker      = GMSMarker()
        let newPosition = CLLocationCoordinate2D(latitude: position.latitude - 0.001, longitude: position.longitude )
        marker.position = newPosition
        marker.title    = cautiousTitle
        marker.snippet  = cautiousSnippet
        let image       = UIImage(named: "WarningPin-13")
        marker.icon     = resizeImage(image: image!, newWidth: 40)
        marker.map      = mapView
    }
    
    func showPoliceMarker(position: CLLocationCoordinate2D, policeDepartment: String, hoursOfOperation: String){
        let marker = GMSMarker()
        let newPosition = CLLocationCoordinate2D(latitude: position.latitude - 0.001, longitude: position.longitude )
        marker.position = newPosition
        marker.title = policeDepartment
        marker.snippet = hoursOfOperation
        let image = UIImage(named: "PolicePin-11")
        marker.icon = resizeImage(image: image!, newWidth: 25)
        marker.map = mapView
    }
    
    func showSafeSpotMarker(position: CLLocationCoordinate2D, safeSpot: String, description: String){
        let marker = GMSMarker()
        let newPosition = CLLocationCoordinate2D(latitude: position.latitude - 0.001, longitude: position.longitude )
        marker.position = newPosition
        marker.title = safeSpot
        marker.snippet = description
        let image = UIImage(named: "SafePin-12")
        marker.icon = resizeImage(image: image!, newWidth: 25)
        marker.map = mapView
    }
    
    func drawCircle(lat: Double, long: Double, opacity: CGFloat, radius: CLLocationDistance){
        let circleCenter = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let circ = GMSCircle(position: circleCenter, radius: radius)
        let col = UIColor(red: 1, green: 0, blue: 0, alpha: opacity)
        circ.fillColor = col
        circ.strokeColor = .clear
        circ.map = mapView
    }
    
    func getLocation(){
        let status  = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined {
            locationMgr.requestAlwaysAuthorization()
            locationMgr.requestWhenInUseAuthorization()
            return
        }
        
        if status == .denied || status == .restricted {
            let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        locationMgr.delegate = self
        locationMgr.desiredAccuracy = kCLLocationAccuracyBest
        locationMgr.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationMgr.startUpdatingLocation()
            currentLocation = locationMgr.location
            lattitude = currentLocation.coordinate.latitude
            longitude = currentLocation.coordinate.longitude
            //locationManager.startUpdatingHeading()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0] as CLLocation
        lattitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
}

extension MapViewController: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("didTapInfoWindowOf")
    }
    
    /* handles Info Window long press */
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        print("didLongPressInfoWindowOf")
    }
    
    /* set a custom Info Window */
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        
        let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.size.width - 16, height: 15))
        lbl1.text = "Hi there!"
        view.addSubview(lbl1)
        
        let lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: view.frame.size.width - 16, height: 15))
        lbl2.text = "I am a custom info window."
        lbl2.font = UIFont.systemFont(ofSize: 14, weight: .light)
        view.addSubview(lbl2)
        
        return view
    }
}


extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportCell", for: indexPath)
        return cell
    }
    
    
}
