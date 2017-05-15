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
    
    var comments = [Comments]()
    
    private var loadedComments = [String: String]()
    
    // handler
    var handle:FIRDatabaseHandle?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dbRef = FIRDatabase.database().reference()
        
        // Loads data to cell.
        loadData()
        
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

        return cell
    }
    
    private func loadData()
    {
        let place = "Dio Con Dio"
        
        dbRef!.child(place+"/comment").observe(.childAdded, with: {
            (snapshot) in
            let label = snapshot.value as! String
            self.updatePlace(snapshot.key, label: label)
        })
        
    }
    
    private func updatePlace(_ key: String, label: String? = nil)
    {
        if let label = label {
            loadedComments[key] = label
            
        }
        guard let label = loadedComments[key] else {
            return
        }
        if let comment = Comments(comment: label) {
            comments.append(comment)
            commentsTableView.reloadData()
        }
    }
    
}
