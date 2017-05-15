//
//  Locations.swift
//  Smoke Free Areas
//
//  Created by Alexandros Andreadis on 10/05/2017.
//  Copyright © 2017 Alexandros Andreadis. All rights reserved.
//

import UIKit
import MapKit

class Locations: NSObject, MKAnnotation {
    // required coordinate, title, and the reuse identifier for this annotation
    var identifier = "locations"
    var title: String?
    var coordinate: CLLocationCoordinate2D
    //initializer taking a name, a latitude and longitude to populate the title and coordinate for each instance of this object
    init(name:String,lat:CLLocationDegrees,long:CLLocationDegrees){
        title = name
        coordinate = CLLocationCoordinate2DMake(lat, long)
    }
    
}
// Creating the list of the places that will be pinned in map
class LocationList: NSObject {
    var Location = [Locations]()
    override init(){
        Location += [Locations(name: "Dio Con Dio", lat: 40.590130, long: 23.036610)]
        Location += [Locations(name: "Paradosiako - Panorama", lat: 40.590102, long:23.036180)]
        Location += [Locations(name: "Veranda",  lat: 40.607740, long: 23.103044)]
        Location += [Locations(name: "Markiz",  lat: 40.634252, long: 22.936276)]
        Location += [Locations(name: "Moi Lounge Bar",  lat: 40.653481, long: 22.994131)]
        Location += [Locations(name: "Boulevard Lounge Bar",  lat: 40.658462, long: 22.983198)]
        Location += [Locations(name: "Ernést Hébrard",  lat: 40.631829, long: 22.941014)]
        Location += [Locations(name: "Tribeca - All Day & Night Bar",  lat: 40.631029, long: 22.942396)]
        
    }
}
