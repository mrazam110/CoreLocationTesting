//
//  RouteSelectionViewController.swift
//  BikerApp
//
//  Created by Raza Master on 12/26/14.
//  Copyright (c) 2014 Maroof. All rights reserved.
//

import UIKit

class RouteSelectionViewController: UIViewController,
                        CLLocationManagerDelegate,
                        GMSMapViewDelegate {
    
    
    @IBOutlet weak var myVIew: UIView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var btnDone: UIBarButtonItem!
    let Karachi = CLLocationCoordinate2D(latitude: 24.8600, longitude: 67.0100)
    let Islamabad = CLLocationCoordinate2D(latitude: 33.7167, longitude: 73.0667)
    let Lahore = CLLocationCoordinate2D(latitude: 31.5497, longitude: 74.3436)
    let Quetta = CLLocationCoordinate2D(latitude: 30.1833, longitude: 67.0000)
    
    var selectedCity: CLLocationCoordinate2D!
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    
    let startMarker: Marker = Marker(marker: GMSMarker(),
        title: "Starting Point!",
        color: UIColor.blackColor())
    let endMarker:   Marker = Marker(marker: GMSMarker(),
        title: "Finishing Point!",
        color: UIColor.blueColor())
    
    var starter: Bool = false
    var ender: Bool = false
    
    var enableStarter: Bool = false
    var enableEnder: Bool = false
    
    
    func isDropped(marker:GMSMarker) -> Bool {
        if marker.map == nil {
            return false
        } else {
            return true
        }
    }
    
    override func viewDidLoad() {

        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapView.mapType = kGMSTypeNormal
        mapView.settings.compassButton = true
        mapView.setMinZoom(12, maxZoom: 20)
        
        locationManager.delegate = self
        mapView.delegate = self
        selectedCity = Karachi
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            println("Authorized!")
            
            locationManager.startUpdatingLocation()
        } else {
            println("Unauthorized!")
            
            mapView.camera = GMSCameraPosition(target: selectedCity, zoom: 15, bearing: 0, viewingAngle: 0)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let location = locations.first as? CLLocation {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            if let _location = locations.last as? CLLocation {
                let marker = GMSMarker(position: _location.coordinate)
                marker.map = mapView
            }
            locationManager.stopUpdatingLocation()
        }
    }
    
    @IBAction func mapTypeToggle(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            mapView.mapType = kGMSTypeNormal
            
        } else {
            mapView.mapType = kGMSTypeTerrain
            
        }
    }
    
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        
        var adjustMarker: GMSMarker
        var color: UIColor
        var isAlreadyDropped: Bool
        var title: String
        
        if enableStarter {
            adjustMarker = startMarker.marker
            isAlreadyDropped = starter
            color = startMarker.color
            title = startMarker.title
            
        } else if enableEnder {
            adjustMarker = endMarker.marker
            isAlreadyDropped = ender
            color = endMarker.color
            title = endMarker.title
            
        } else {
            return
            
        }
        
        if isAlreadyDropped {
            adjustMarker.map = nil
        }
        
        adjustMarker.position = coordinate
        adjustMarker.appearAnimation = kGMSMarkerAnimationPop
        adjustMarker.icon = GMSMarker.markerImageWithColor(color)
        adjustMarker.title = title
        adjustMarker.draggable = true
        adjustMarker.map = mapView
        isAlreadyDropped = false
        
        if isDropped(startMarker.marker) && isDropped(endMarker.marker) {
            
            //TODO: Draw route code
        }
    }
    
    @IBAction func enableStartMarker(sender:UIButton) {
        enableStarter = true
        enableEnder = false
    }
    
    @IBAction func enableEndMarker(sender:UIButton) {
        enableEnder = true
        enableStarter = false
    }
    
    @IBAction func Done(sender: UIBarButtonItem) {
        
        //let source: createEventController = self.navigationController?.viewControllers[1] as createEventController
        
        /*if isDropped(startMarker.marker) && isDropped(endMarker.marker) {
            var coordinate = midPoint(startMarker.marker.position, second: endMarker.marker.position)
            source.presentMapView.clear()
            startMarker.marker.map = source.presentMapView
            endMarker.marker.map = source.presentMapView
            source.presentMapView.camera = GMSCameraPosition(target: coordinate, zoom: 12, bearing: 0, viewingAngle: 0)
            source.presentMapView.hidden = false
            source.isMapAvailable = true
            source.startCoordinates = startMarker.marker.position
            source.finishCoordinates = endMarker.marker.position
            navigationController?.popViewControllerAnimated(true)
            
        }*/
    }
    
    override func viewWillAppear(animated: Bool) {
        /*let source: createEventController = self.navigationController?.viewControllers[1] as createEventController
        if source.startCoordinates != nil {
            startMarker.marker.position = source.startCoordinates
            startMarker.marker.icon = GMSMarker.markerImageWithColor(startMarker.color)
            startMarker.marker.title = startMarker.title
            startMarker.marker.draggable = true
            startMarker.marker.map = mapView
            endMarker.marker.position = source.finishCoordinates
            endMarker.marker.map = mapView
            endMarker.marker.icon = GMSMarker.markerImageWithColor(endMarker.color)
            endMarker.marker.title = endMarker.title
            endMarker.marker.draggable = true
        }
        
        self.view.frame = CGRectMake(0, 0, screenRect.width, screenRect.height + 150)*/
    }
    
    func midPoint(first:CLLocationCoordinate2D, second:CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        
        var logitude = (first.longitude + second.longitude) / 2
        var latitude = (first.latitude + second.latitude) / 2
        return CLLocationCoordinate2D(latitude: latitude, longitude: logitude)
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    
}

struct Marker {
    let marker: GMSMarker
    let title: String
    let color: UIColor
    
}

