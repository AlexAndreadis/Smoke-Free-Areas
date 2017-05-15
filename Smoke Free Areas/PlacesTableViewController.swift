//
//  PlacesTableViewController.swift
//  Smoke Free Areas
//
//  Created by Alexandros Andreadis on 26/04/2017.
//  Copyright © 2017 Alexandros Andreadis. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PlacesTableViewController: UITableViewController {
    
    //MARK: Properties
    @IBOutlet weak var placesTableView: UITableView!
    
    //database reference
    var dbRef:FIRDatabaseReference?
    
    var places = [Places]()
    
    private var loadedLabels = [String: String]()
    private var loadedRatings = [String: Int]()
    
    //handler
    var handle:FIRDatabaseHandle?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dbRef = FIRDatabase.database().reference()
        
        // Loads data to cell.
        loadData()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {   
        //return the number of rows
        return places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PlacesTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlacesTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PlacesTableView Cell.")
        }
        
        let place = places[indexPath.row]
        
        cell.placeLabel.text = place.name
        cell.ratingControl.rating = place.rating
        
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "ShowCommentsTableViewController", sender: nil)
    }
    
    //MARK: Private Methods
    
    private func loadData()
    {
        let place = "Dio Con Dio"
        
        dbRef!.child(place+"/placeLabel").observe(.childAdded, with: {
            (snapshot) in
            let label = snapshot.value as! String
            self.updatePlace(snapshot.key, label: label)
        })
        dbRef!.child(place+"/rating").observe(.childAdded, with: {
            (snapshot) in
            let rating = snapshot.value as! Int
            self.updatePlace(snapshot.key, rating: rating)
        })
        
        
    }
    
    private func updatePlace(_ key: String, label: String? = nil, rating: Int? = nil)
    {
        if let label = label {
            loadedLabels[key] = label
            
        }
        if let rating = rating {
            loadedRatings[key] = rating
        }
        guard let label = loadedLabels[key], let rating = loadedRatings[key] else {
            return
        }
        if let place = Places(name: label, rating: rating) {
            places.append(place)
            placesTableView.reloadData()
        }
    }
    
    /*func average(numbers: Int...) -> Int
    {
        var sum = 0
        for number in numbers {
            sum += number
        }
        let  ave : Int = Int(sum) / Int(numbers.count)
        return ave
    }*/

}
