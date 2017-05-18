//
//  RatingControl.swift
//  Smoke Free Areas
//
//  Created by Alexandros Andreadis on 19/04/2017.
//  Copyright © 2017 Alexandros Andreadis. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    // MARK: Properties
    private var ratingButtons = [UIButton]()
    
    var rating = 0{
        didSet
        {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var cigaretteSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet
        {
            setupButtons()
        }
    }
    @IBInspectable var cigaretteCount: Int = 5{
        didSet
        {
            setupButtons()
        }
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupButtons()
    }
    required init(coder:NSCoder){
        super.init(coder:coder)
        setupButtons()
    }
    
    //MARK: Private Methods
    
    private func setupButtons() {
        
        
        // clearing existing buttons
        for button in ratingButtons
        {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let coloredCigar = UIImage(named: "coloredCigar", in: bundle, compatibleWith: self.traitCollection)
        let emptyCigar = UIImage(named:"emptyCigar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedCigar = UIImage(named:"highlightedCigar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<cigaretteCount
        {
            
            //Create the button
            let button = UIButton()
            // Set the button images
            button.setImage(emptyCigar, for: .normal)
            button.setImage(coloredCigar, for: .selected)
            button.setImage(highlightedCigar, for: .highlighted)
            button.setImage(highlightedCigar, for: [.highlighted, .selected])
            //Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: cigaretteSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: cigaretteSize.width).isActive = true
            
            // Set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) cigar rating"
            // Add the button to the stack
            addArrangedSubview(button)
            // Add the new button to the rating button array
            ratingButtons.append(button)
            // Set up the button Action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
        }
        updateButtonSelectionStates()
        
    }
    
    //MARK: Button Action
    
    func ratingButtonTapped(button: UIButton){
        guard let index = ratingButtons.index(of: button) else
        {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating
        {
            // If the selected cigar represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
        
    }
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated()
        {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
            
            // Set the hint string for the currently selected cigar
            let hintString: String?
            if rating == index + 1
            {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            // Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 cigar set."
            default:
                valueString = "\(rating) cigars set."
            }
            
            // Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }

}
