//
//  CommentsTableViewController.swift
//  Smoke Free Areas
//
//  Created by Alexandros Andreadis on 14/05/2017.
//  Copyright © 2017 Alexandros Andreadis. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CommentsTableViewController: UITableViewController {
    
    //MARK: Properties
    @IBOutlet weak var commentsTableView: UITableView!
    
    var dbRef:FIRDatabaseReference?
    var passedValue: String?
    
    var comments = [Comments]()
    
    private var loadedComments = [String: String]()
    private var loadedRatings = [String: Int]()
    
    // handler
    var handle:FIRDatabaseHandle?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dbRef = FIRDatabase.database().reference()
        
        // Loads data to cell.
        loadData()
        self.title = passedValue
        
    }

    override func didReceiveMemoryWarning() {
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
        // return the number of rows
        return comments.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CommentsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CommentsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CommentsTableViewCell.")
        }
        
        let comment = comments[indexPath.row]
        cell.commentField.text = comment.comment
        cell.numberLabel.text = String(format: "#%i", indexPath.row+1)
        cell.commentField.isEditable = false
        cell.ratingLabel.text = String("Rating: \(comment.rating)/5")

        return cell
    }
    
    private func loadData()
    {
        let place = passedValue
        dbRef!.child(place!+"/comment").observe(.childAdded, with: {
            (snapshot) in
            let label = snapshot.value as! String
            self.updatePlace(snapshot.key, label: label)
        })
        dbRef!.child(place!+"/rating").observe(.childAdded, with: {
            (snapshot) in
            let rating = snapshot.value as! Int
            self.updatePlace(snapshot.key, rating: rating)
        })
    }
    
    private func updatePlace(_ key: String, label: String? = nil, rating: Int? = nil)
    {
        if let label = label
        {
            loadedComments[key] = label
        }
        if let rating = rating
        {
            loadedRatings[key] = rating
        }
        guard let label = loadedComments[key], let rating = loadedRatings[key] else {
            return
        }
        if let comment = Comments(comment: label, rating: rating)
        {
            comments.append(comment)
            commentsTableView.reloadData()
        }
    }
    
}
