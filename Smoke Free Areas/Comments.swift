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
    
    //MARK:Types
    
    struct PropertyKey {
        static let comment = "comment"
        
    }
    
    //MARK: Initialization
    
    init?(comment: String) {
        
        // Initialize stored properties.
        self.comment = comment
        
        // Initialization should fail if there is no name or if the rating is negative.
        // The name must not be empty
        guard !comment.isEmpty else {
            return nil
        }
        
    }
    
}
