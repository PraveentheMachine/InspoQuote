//
//  FavouriteQuoteTableViewCell.swift
//  Quotables
//
//  Created by Praveen Bandarage on 7/12/20.
//

import UIKit

//Protocol for handling interactions withthe share button
protocol FavouriteQuoteTableViewCellDelegate: AnyObject {
    func didTapShareButton(with quoteText: String, with authorText: String)
}

class FavouriteQuoteTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var quoteView: UIView!
    
    
    weak var delegate : FavouriteQuoteTableViewCellDelegate?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        shareButton.backgroundColor = .clear
        shareButton.layer.cornerRadius = 8
        shareButton.layer.borderWidth = 1
        shareButton.layer.backgroundColor = Statics.defaultPurpleColour.cgColor
    }


    @IBAction func shareButtonPressed(_ sender: UIButton) {
     
        delegate?.didTapShareButton(with: quoteLabel.text!, with: authorLabel.text!)

    }
    
}








