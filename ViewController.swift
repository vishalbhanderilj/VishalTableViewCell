//
//  ViewController.swift
//  googleMapDemo1
//
//  Created by Manish Dodiya on 14/05/18.
//  Copyright © 2018 manishdodiya. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
 let locationManager = CLLocationManager()
    
    
    @IBOutlet var mapView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        
//        let lat = self.locationManager.location?.coordinate.latitude
//        let long = self.locationManager.location?.coordinate.longitude
//
//
//        let camera = GMSCameraPosition.camera(withLatitude: lat!, longitude: long!, zoom: 10)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        view = mapView
//        self.locationManager.delegate = self
//        self.locationManager.startUpdatingLocation()
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
        // Do any additional setup after loading the view, typically from a nib.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.showCurrentlocation()
        self.locationManager.stopUpdatingLocation()
    }
    
    
    func showCurrentlocation(){
        let camera = GMSCameraPosition.camera(withLatitude: (self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!, zoom: 10)
        //        let mapView = GMSMapView.map(withFrame: CGRect(0,0,self.mpView.frame.size.width,self.mpView.frame.size.height
        //        ), camera: camera)
        
        let mapView = GMSMapView.map(withFrame: CGRect(x:0,y: 0,width: self.mapView.frame.size.width,height: self.mapView.frame.size.height
        ), camera: camera)
        
        mapView.settings.myLocationButton=true
        mapView.isMyLocationEnabled=true
        
        
        let marker = GMSMarker()
        marker.position = camera.target
        marker.snippet="Current Location"
        
        // marker.appearAnimation = GMSMarkerAnimation
        marker.map=mapView
        self.mapView.addSubview(mapView)
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

