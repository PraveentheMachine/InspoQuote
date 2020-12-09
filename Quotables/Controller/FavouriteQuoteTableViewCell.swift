//
//  FavouriteQuoteTableViewCell.swift
//  Quotables
//
//  Created by Praveen Bandarage on 7/12/20.
//

import UIKit

class FavouriteQuoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var quoteView: UIView!
    let buttonColour = UIColor(red: 0.19, green: 0.20, blue: 0.42, alpha: 1.00)

    
    override func awakeFromNib() {
        super.awakeFromNib()
        shareButton.backgroundColor = .clear
        shareButton.layer.cornerRadius = 8
        shareButton.layer.borderWidth = 1
        shareButton.layer.backgroundColor = buttonColour.cgColor
    }


}
