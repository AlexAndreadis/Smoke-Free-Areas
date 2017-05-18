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
        let fieldTextLength = commentTextField.text!.characters.count
        if  fieldTextLength < 40 {
            createAlert(title: "Too short review", message: "Please say more, add details and help non-smokers.\nMininmum characters:40")
        }else{
            //Saving item to database
            if commentTextField.text !=  "" && placeLabel.text != "Location"
            {
                let place = placeLabel.text
            
                let key = dbRef!.child("placeLabel").childByAutoId().key

                dbRef!.child(place!+"/placeLabel").child(key).setValue(place)
                dbRef!.child(place!+"/rating").child(key).setValue(ratingControl.rating)
                dbRef!.child(place!+"/comment").child(key).setValue(commentTextField.text)
            
                //alert
                createAlert(title: "Thank you!", message: "Review submitted.")
                commentTextField.text = ""
                self.navigationController?.popViewController(animated: false)
            }else{
                print("Error saving to database. :saveBtn")
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        
        return true
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
