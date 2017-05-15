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
    
    var myList:[String] = []
    
    var handle:FIRDatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = FIRDatabase.database().reference()
        
        handle = dbRef?.child("list").observe(.childAdded, with: { (snapshot) in
            
            if let item = snapshot.value as? String
            {
                self.myList.append(item)
                self.placesTableView.reloadData()
            }
        })
        
        // Load the sample data.
        //loadSamplePlaces()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PlacesTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            cellIdentifier, for: indexPath) as? PlacesTableViewCell else {
            fatalError("The dequeued cell is not an instance of PlaceTableViewCell.")
        }
        
        // Fetches the appropriate place for the data source layout.
        let place = places[indexPath.row]

        cell.placeLabel.text = place.name
        cell.placeImageView.image = place.photo
        cell.ratingControl.rating = place.rating
        
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.placeLabel?.text = myList[indexPath.row]

        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Private Methods
    
    /*private func loadSamplePlaces() {
        
        let photo1 = UIImage(named: "place1")
        
        guard let place1 = Places(name: "ARC - Aroma Refines Class", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate place1")
            
        }
        places += [place1]
    }*/
    
    

}
