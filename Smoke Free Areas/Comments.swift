//
//  Comments.swift
//  Smoke Free Areas
//
//  Created by Alexandros Andreadis on 15/05/2017.
//  Copyright © 2017 Alexandros Andreadis. All rights reserved.
//

import UIKit

class Comments {
    
    //MARK: Properties
    
    var comment: String
    var rating: Int
    
    //MARK:Types
    
    struct PropertyKey {
        static let comment = "comment"
        static let rating = "rating"
    }
    
    //MARK: Initialization
    
    init?(comment: String, rating: Int) {
        
        // Initialize stored properties.
        self.comment = comment
        self.rating = rating
        
        // Initialization should fail if there is no name or if the rating is negative.
        // The name must not be empty
        guard !comment.isEmpty else {
            return nil
        }
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
    }
    
}
