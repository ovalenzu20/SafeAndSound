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
    
    @IBOutlet fileprivate weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocation()
        let camera = GMSCameraPosition.camera(withLatitude: 37.785834, longitude: -122.406417, zoom: 10)
        mapView.camera = camera
        
        showEmergencyMarker(position: camera.target, emergencyTitle: "SD HACKS ALMOST OVER", emergencySnippet: "21 hours left")
        drawCircle(lat: lattitude ,long: longitude, opacity: 0.15, radius: 1000)
        
        let newPosition = CLLocationCoordinate2D(latitude: lattitude - 0.05, longitude: longitude - 0.05 )
        showEmergencyMarker(position: newPosition, emergencyTitle: "SD HACKS 2018", emergencySnippet: "123456789")
        
        drawCircle(lat: newPosition.latitude, long: newPosition.longitude, opacity: 0.15, radius: 1000)
        mapView.settings.myLocationButton = true
        
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
    
    func showEmergencyMarker(position: CLLocationCoordinate2D, emergencyTitle: String, emergencySnippet: String){
        let marker = GMSMarker()
        let newPosition = CLLocationCoordinate2D(latitude: position.latitude - 0.001, longitude: position.longitude )
        marker.position = newPosition
        marker.title = emergencyTitle
        marker.snippet = emergencySnippet
        let image = UIImage(named: "AlertPin-10")
        marker.icon = resizeImage(image: image!, newWidth: 40)
        marker.map = mapView
    }
    
    func showCautiousMarker(position: CLLocationCoordinate2D, cautiousTitle: String, cautiousSnippet: String){
        let marker = GMSMarker()
        let newPosition = CLLocationCoordinate2D(latitude: position.latitude - 0.001, longitude: position.longitude )
        marker.position = newPosition
        marker.title = cautiousTitle
        marker.snippet = cautiousSnippet
        let image = UIImage(named: "WarningPin-13")
        marker.icon = resizeImage(image: image!, newWidth: 40)
        marker.map = mapView
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
