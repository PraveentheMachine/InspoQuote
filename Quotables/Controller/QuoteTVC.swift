//
//  QuoteTVC.swift
//  Quotables
//
//  Created by Praveen Bandarage on 3/12/20.
//

import UIKit

class QuoteTVC: UITableViewCell {

    let buttonColour = UIColor(red: 0.19, green: 0.20, blue: 0.42, alpha: 1.00)
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var quoteView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        copyButton.backgroundColor = .clear
        copyButton.layer.cornerRadius = 8
        copyButton.layer.borderWidth = 1
        copyButton.layer.backgroundColor = buttonColour.cgColor
        
//        shareButton.backgroundColor = .clear
//        shareButton.layer.cornerRadius = 8
//        shareButton.layer.borderWidth = 1
//        shareButton.layer.backgroundColor = UIColor.black.cgColor
        
        favouriteButton.backgroundColor = .clear
        favouriteButton.layer.cornerRadius = 8
        favouriteButton.layer.borderWidth = 1
        favouriteButton.layer.backgroundColor = buttonColour.cgColor
        
        shareButton.backgroundColor = .clear
        shareButton.layer.cornerRadius = 8
        shareButton.layer.borderWidth = 1
        shareButton.layer.backgroundColor = buttonColour.cgColor
        


        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
            
        // Configure the view for the selected state
    }

}
