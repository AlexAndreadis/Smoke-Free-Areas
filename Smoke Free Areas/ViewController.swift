//
//  ViewController.swift
//  Smoke Free Areas
//
//  Created by Alexandros Andreadis on 19/04/2017.
//  Copyright © 2017 Alexandros Andreadis. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase

class RateViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //MARK: Properties
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var placeLabel: UILabel!
    
    var placeLabelString = String()
    
    //database reference
    var dbRef:FIRDatabaseReference?
    
    
    //Send button action
    @IBAction func saveBtn(_ sender: Any) {
        
        //Saving item to database
        if commentTextField.text !=  "" && placeLabel.text != "Location"
        {
            
            let place = placeLabel.text
            
            let key = dbRef!.child("placeLabel").childByAutoId().key
            
            
            dbRef!.child(place!+"/placeLabel").child(key).setValue(place)
            dbRef!.child(place!+"/comment").child(key).setValue(commentTextField.text)
            dbRef!.child(place!+"/rating").child(key).setValue(ratingControl.rating)
            
            commentTextField.text = ""
            //alert
            createAlert(title: "Thank you!", message: "Review submitted.")
            self.navigationController?.popViewController(animated: true)
        }else{
            //alert
            createAlert(title: "", message: "Please pick a location from the map and write a review.")
        }
    }
   
    
    // alert function
    func createAlert (title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        commentTextField.delegate = self
        //database refernce
        dbRef = FIRDatabase.database().reference()
        // telling that placeLabel is a string
        placeLabel.text = placeLabelString
  
    }
    

}
