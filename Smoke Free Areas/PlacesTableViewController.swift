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
    var valueToPass:String!
    let cellIdentifier = "PlacesTableViewCell"
    
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
        let indexPath = placesTableView.indexPathForSelectedRow
        
        let place = places[(indexPath?.row)!]
        valueToPass = place.name
        print(valueToPass)
        
        performSegue(withIdentifier: "ShowCommentsTableViewController", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowCommentsTableViewController") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! CommentsTableViewController
            // will be stored in passedValue on the CommentsTableViewController
            viewController.passedValue = valueToPass
            //print (viewController.passedValue ?? "")
        }
    }
    
    //MARK: Private Methods
    
    private func loadData()
    {
        dbRef!.observe(.childAdded, with: {
            (placeSnapshot) in
            //print("Adding place \(placeSnapshot.key)...")
            
            let labels = placeSnapshot.childSnapshot(forPath: "placeLabel")
            
            for (key, label) in labels.value as! [String: String] {
                self.updatePlace(key, label: label)
            }
            let ratings = placeSnapshot.childSnapshot(forPath: "rating")
            for (key, rating) in ratings.value as! [String: Int] {
                self.updatePlace(key, rating: rating)
            }
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

}
