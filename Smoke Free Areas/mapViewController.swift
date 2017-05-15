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
    
    // all locations will be stored on this array
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations [0]
        
        //map zoomed
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.004, 0.004)
        //users location
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
        
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
                
                let reviewButton = UIButton(type: .detailDisclosure)
                
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
        // after touching a pin i moves to next view controller
        //self.performSegue(withIdentifier: "ShowRateViewController", sender: nil)
        
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        coreLocationManager.delegate = self
        //desired accuracy is the best accuracy, very accurate data for the location
        coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        //request authorization from the user when user using my app
        coreLocationManager.requestWhenInUseAuthorization()
        
        coreLocationManager.startUpdatingLocation()
        
        mapView.delegate = self
        
        mapView.addAnnotations(locations)
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
