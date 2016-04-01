//
//  ViewController.swift
//  LocationDemo
//
//  Created by Kioko on 01/04/2016.
//  Copyright © 2016 Thomas Kioko. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var latitude :CLLocationDegrees!
    var longitude :CLLocationDegrees!
    
    //Difference between one side of the screen ot the other/ Zoom in
    let latDelata : CLLocationDegrees = 0.01
    let longDelata : CLLocationDegrees = 0.01
    
    var locationManager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get the users location
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This method is called when the users location changes
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //convert the location to CLLocation
        let userLocation : CLLocation = locations[0] as CLLocation
        
        //Extract latitude
        self.latitude = userLocation.coordinate.latitude
        //Extract logitude
        self.longitude = userLocation.coordinate.longitude
        
        let span : MKCoordinateSpan = MKCoordinateSpanMake(latDelata, longDelata)
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.latitude, self.longitude)
        let mapRegion : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.mapView.setRegion(mapRegion, animated: true)
        self.mapView.showsUserLocation = true
        self.mapView.zoomEnabled = true
        
    }


}

