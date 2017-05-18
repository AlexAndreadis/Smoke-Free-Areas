//
//  CommentsTableViewCell.swift
//  Smoke Free Areas
//
//  Created by Alexandros Andreadis on 15/05/2017.
//  Copyright © 2017 Alexandros Andreadis. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell, UITableViewDelegate {

    //MARK: Properties
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var commentField: UITextView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
