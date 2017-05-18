//
//  mapViewController.swift
//  Smoke Free Areas
//
//  Created by Alexandros Andreadis on 11/05/2017.
//  Copyright © 2017 Alexandros Andreadis. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // MARK: Properties
    let pin = UIImage(named: "pin")
    var annotationTouched = String()
    var viaSegue = MKAnnotationView()
    
    // MARK: MAP
    @IBOutlet weak var mapView: MKMapView!

    let coreLocationManager = CLLocationManager()
    let locations = LocationList().Location
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        // all locations will be stored on this array
        let location = locations [0]
        
        //map zoomed
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005)
        //users location
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: false)
        
        self.mapView.showsUserLocation = true
    }
    
    // func to change red pin to my custom pin
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        
        
        if let annotation = annotation as? Locations{
            if let view = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier){
                return view
            }else{
                let gesture = UITapGestureRecognizer(target: self, action: #selector(calloutTapped(sender:)))
                let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)
                view.image = pin
                view.isEnabled = true
                view.canShowCallout = true
                
                let reviewButton = UIButton(type: .contactAdd)
                
                view.rightCalloutAccessoryView = reviewButton
                
                reviewButton.addGestureRecognizer(gesture)
                
                return view
                
            }
        }
        return nil
    }
    
    // assigning the pin that is selected in the map to the annotation touched variable
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        // assigning the pin that is selected in the map to the annotation touched variable
        if let annotation = view.annotation as? Locations {
            annotationTouched = annotation.title ?? "No title"
        }
        
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mapView.addAnnotations(locations)
        
        mapView.delegate = self
        
        //desired accuracy is the best accuracy, very accurate data for the location
        coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        //request authorization from the user when user using my app
        coreLocationManager.requestAlwaysAuthorization()
        coreLocationManager.requestWhenInUseAuthorization()
        coreLocationManager.startUpdatingLocation()
        
        coreLocationManager.delegate = self
    }
    
    // passing the name of the place on the next view controller which is the review view controller (RateViewController)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let destViewController : RateViewController = segue.destination as! RateViewController
        destViewController.placeLabelString = annotationTouched
    }
    func calloutTapped(sender:UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowRateViewController", sender: self)
    }
    

}
