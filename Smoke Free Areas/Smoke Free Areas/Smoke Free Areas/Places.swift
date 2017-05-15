//
//  Places.swift
//  Smoke Free Areas
//
//  Created by Alexandros Andreadis on 26/04/2017.
//  Copyright © 2017 Alexandros Andreadis. All rights reserved.
//

import UIKit

class Places {

    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK:Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
        // Initialization should fail if there is no name or if the rating is negative.
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
    }

}
