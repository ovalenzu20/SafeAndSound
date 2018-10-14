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
    var lattitude       : CLLocationDegrees = 0
    var longitude       : CLLocationDegrees = 0
    var currentLocation : CLLocation!
    var notSafeButton   : UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    @IBOutlet weak var profileButton      : UIButton!
    @IBOutlet weak var createReportButton : UIButton!
    @IBOutlet weak var helpButton         : UIButton!
    
    
    var viewDownOffset: CGFloat!
    var viewUp: CGPoint!
    var viewDown: CGPoint!
    
    
    @IBOutlet fileprivate weak var mapView        : GMSMapView!
    @IBOutlet weak var reportContainerView        : UIView!
    @IBOutlet weak var reportImageView            : UIImageView!
    @IBOutlet weak var recentReportsContainerView : UIView!
    @IBOutlet weak var reportsTableView           : UITableView!
    @IBOutlet weak var recentReportsLabel         : UILabel!
    
    
    var originalReportContainerViewCenter: CGPoint!
    
    
    
    
    
    @IBAction func didPanReportContainerView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            originalReportContainerViewCenter = reportContainerView.center
        }
        else if sender.state == .changed {
            reportContainerView.center = CGPoint(x: originalReportContainerViewCenter.x, y: originalReportContainerViewCenter.y + translation.y)
        }
        else if sender.state == .ended {
            let velocity = sender.velocity(in: view)
            
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.3) {
                    self.reportContainerView.center = self.viewDown
                }
            }
            else {
                UIView.animate(withDuration: 0.3) {
                    self.reportContainerView.center = self.viewUp
                }
            }
        }
    }
    
    
    @objc private func alertSystem() {
        let shouldAlertController = UIAlertController(title: "Are you ok?", message: "Would you like us to contact the authorities?", preferredStyle: .alert)
        let alertedController = UIAlertController(title: "Authorities Have Been Alerted", message: "Please quickly proceed to the nearest Safe Spot", preferredStyle: .alert)
        
        let okAction1    = UIAlertAction(title: "I'm fine", style: .default, handler: nil)
        let notOkAction = UIAlertAction(title: "No! Please help!", style: .default) { (action) in
            self.present(alertedController, animated: true, completion: nil)
        }
        
        let okAction2    = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        shouldAlertController.addAction(okAction1)
        shouldAlertController.addAction(notOkAction)
        alertedController.addAction(okAction2)
        
        self.present(shouldAlertController, animated: true, completion: nil)
    }
    
    
    @objc private func createReport() {
        showCautiousMarker(position: CLLocationCoordinate2D(latitude: lattitude, longitude: longitude), cautiousTitle: "CAUTION", cautiousSnippet: "A user recommends to be cautious around here ")
        
    }
    
    
    @objc private func viewProfile() {
        self.performSegue(withIdentifier: "viewProfileSegue", sender: self)
    }
    var crimeReports : [CrimeReport] = [] {
        didSet {
            displayCrimeReports()
        }
    }
    
    fileprivate func setupViews() {
        reportContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, height: view.frame.height / 2)
        
        reportImageView.anchor(top: reportContainerView.topAnchor, leading: reportContainerView.leadingAnchor, bottom: nil, trailing: nil, padding: Padding(top: 22, left: 16), width: (reportContainerView.frame.width / 2) - 16, height: (reportContainerView.frame.width / 2) - 16)
        
        reportImageView.setProperties(bgColor: nil, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: 2, borderColor: .white, borderWidth: 4)
        
        view.addSubview(notSafeButton)
        view.addSubview(profileButton)
        view.addSubview(createReportButton)
        view.addSubview(helpButton)
        
        notSafeButton.anchor(top: nil, leading: nil, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: Padding(right: 22, bottom: 22), width: view.frame.width / 5, height: ((view.frame.width / 5) * 1650) / 992)
        notSafeButton.setBackgroundImage(#imageLiteral(resourceName: "HelpButton-18"), for: .normal)
        notSafeButton.imageView?.contentMode = .scaleAspectFill
        
        profileButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: Padding(top: 32, left: 22), width: 100, height: 100)
        profileButton.setProperties(bgColor: nil, shadowColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), shadowRadius: 2.0, shadowOpacity: 0.7, shadowOffset: CGSize(width: 2.0, height: 2.0), cornerRadius: nil, borderColor: .white, borderWidth: 4.0)
        profileButton.layer.cornerRadius = 50
        profileButton.setBackgroundImage(#imageLiteral(resourceName: "d_user"), for: .normal)
        profileButton.imageView?.contentMode = .scaleAspectFill
        profileButton.clipsToBounds = true
        
        createReportButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: Padding(top: 32, right: 22), width: 50, height: 50)
        createReportButton.setBackgroundImage(#imageLiteral(resourceName: "create_report"), for: .normal)
        createReportButton.setProperties(bgColor: nil, shadowColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), shadowRadius: 2.0, shadowOpacity: 0.7, shadowOffset: CGSize(width: 2.0, height: 2.0), cornerRadius: nil, borderColor: nil, borderWidth: nil)
        createReportButton.layer.cornerRadius = 25
        
        helpButton.anchor(top: createReportButton.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: Padding(top: 22, right: 22), width: 50, height: 50)
        helpButton.setBackgroundImage(#imageLiteral(resourceName: "help"), for: .normal)
        helpButton.setProperties(bgColor: nil, shadowColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), shadowRadius: 2.0, shadowOpacity: 0.7, shadowOffset: CGSize(width: 2.0, height: 2.0), cornerRadius: nil, borderColor: nil, borderWidth: nil)
        helpButton.layer.cornerRadius = 25
        
        recentReportsContainerView.anchor(top: reportImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: notSafeButton.leadingAnchor, padding: Padding(top: 16, left: 16, right: 16), height: 30)
        
        recentReportsContainerView.setProperties(bgColor: .white, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: recentReportsContainerView.frame.height / 2, borderColor: nil, borderWidth: nil)
        
        reportsTableView.anchor(top: recentReportsContainerView.bottomAnchor, leading: reportContainerView.leadingAnchor, bottom: reportContainerView.bottomAnchor, trailing: notSafeButton.leadingAnchor, padding: Padding(top: 16, left: 16, right: 16, bottom: 16))
        
        recentReportsLabel.anchor(centerY: recentReportsContainerView.centerYAnchor, top: nil, leading: recentReportsContainerView.leadingAnchor,bottom: nil, trailing: nil, padding: Padding(left: 8))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCriminalLocations()
        
        viewDownOffset = 500
        viewUp = reportContainerView.center
        viewDown = CGPoint(x: reportContainerView.center.x, y: reportContainerView.center.y + viewDownOffset)
        
        notSafeButton.addTarget(self, action: #selector(alertSystem), for: .touchUpInside)
        reportsTableView.delegate   = self
        reportsTableView.dataSource = self
        reportsTableView.rowHeight  = UITableView.automaticDimension
        fetchCriminalLocations()
        
        setupViews()
//        lattitude = 37.785834
//        longitude = -122.406417
        let camera = GMSCameraPosition.camera(withLatitude: 34.052235, longitude: -118.243683, zoom: 10)
        mapView.camera = camera
        
//        showEmergencyMarker(position: camera.target, emergencyTitle: "SD HACKS ALMOST OVER")
//        drawCircle(lat: lattitude ,long: longitude, opacity: 0.15, radius: 1000)
        
//        let newPosition = CLLocationCoordinate2D(latitude: lattitude - 0.05, longitude: longitude - 0.05 )
//        showEmergencyMarker(position: newPosition, emergencyTitle: "SD HACKS 2018")
        
//        drawCircle(lat: newPosition.latitude, long: newPosition.longitude, opacity: 0.15, radius: 1000)
       

        mapView.isMyLocationEnabled = true
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
//        let status  = CLLocationManager.authorizationStatus()
//
//        if status == .notDetermined {
//            locationMgr.requestAlwaysAuthorization()
//            locationMgr.requestWhenInUseAuthorization()
//            return
//        }
//
//        if status == .denied || status == .restricted {
//            let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
//
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alert.addAction(okAction)
//
//            present(alert, animated: true, completion: nil)
//            return
//        }
//
//        locationMgr.delegate = self
//        locationMgr.desiredAccuracy = kCLLocationAccuracyBest
//        locationMgr.requestAlwaysAuthorization()
//
//        if CLLocationManager.locationServicesEnabled() {
//
//            locationMgr.startUpdatingLocation()
//            currentLocation = locationMgr.location
//            lattitude = currentLocation.coordinate.latitude
//            longitude = currentLocation.coordinate.longitude
//            //locationManager.startUpdatingHeading()
//        }
        lattitude = 34.052235
        longitude = -118.243683
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
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportCell", for: indexPath) as! ReportCell
        cell.setupCell()
        return cell
    }
}
