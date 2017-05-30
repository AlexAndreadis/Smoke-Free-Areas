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
        Location += [Locations(name: "Veranda Cafe Bar",  lat: 40.607740, long: 23.103044)]
        Location += [Locations(name: "Markiz",  lat: 40.634252, long: 22.936276)]
        Location += [Locations(name: "Moi Lounge Bar",  lat: 40.653481, long: 22.994131)]
        Location += [Locations(name: "Boulevard Lounge Bar",  lat: 40.658462, long: 22.983198)]
        Location += [Locations(name: "Ernést Hébrard",  lat: 40.631829, long: 22.941014)]
        Location += [Locations(name: "Tribeca - All Day & Night Bar",  lat: 40.631029, long: 22.942396)]
        Location += [Locations(name: "Taverna Tou Vaggeli",  lat: 40.613878, long: 23.099086)]
        Location += [Locations(name: "The Loco Bus",  lat: 40.632999, long: 22.939409)]
        Location += [Locations(name: "'Koskia' Restaurant",  lat: 40.612530, long: 23.099330)]
        Location += [Locations(name: "Maronetto Cafe",  lat: 40.614256 , long: 23.097827 )]
        Location += [Locations(name: "Tzaki 'Ho | Country Eating",  lat: 40.608964 , long: 23.100203 )]
        Location += [Locations(name: "Villa Luna",  lat: 40.587021, long: 23.029758 )]
        Location += [Locations(name: "Kritikos Gallery & Restaurants",  lat: 40.589444 , long: 23.037054 )]
        Location += [Locations(name: "Nelson Panorama",  lat: 40.591264 , long: 23.036268 )]
        Location += [Locations(name: "Plaisir Panorama",  lat: 40.591033, long: 23.036357)]
        Location += [Locations(name: "BOHÈME",  lat: 40.546863, long: 22.980900)]
        Location += [Locations(name: "Les Zazous",  lat: 40.586158, long: 22.939636)]
        Location += [Locations(name: "Shark | Café Bar Restaurant",  lat: 40.591169, long: 22.946819)]
        Location += [Locations(name: "Navona Aperitivo & Italian Flavors",  lat: 40.617892, long: 22.952108)]
        Location += [Locations(name: "Δεντρόσπιτο",  lat: 40.625414, long: 22.951556)]
        Location += [Locations(name: "Εφημερίδα",  lat: 40.627674, long: 22.949484)]
    }
}
