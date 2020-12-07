//
//  QuoteTVC.swift
//  Quotables
//
//  Created by Praveen Bandarage on 3/12/20.
//

import UIKit
protocol QuoteTableViewCellDelegate: AnyObject {
    func didTapShareButton(with quoteText: String, with authorName: String)
    func didTapCopyButton(with quoteText: String, with authorName: String)
    func didTapFavouriteButton(with quoteText: String, with authorText: String)
}
class QuoteTableViewCell: UITableViewCell {
    
    weak var delegate: QuoteTableViewCellDelegate?
    let buttonColour = UIColor(red: 0.19, green: 0.20, blue: 0.42, alpha: 1.00)
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var quoteView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupMethod()
    }
    
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        delegate?.didTapShareButton(with: quoteLabel.text!, with: authorLabel.text!)
    }
    
    
    @IBAction func copyButtonPressed(_ sender: UIButton) {
        delegate?.didTapCopyButton(with: quoteLabel.text!, with: authorLabel.text!)
    }
    
    
    //primarily created so that my awakeFromNIB function was tidier
    func setupMethod () {
        
        copyButton.backgroundColor = .clear
        copyButton.layer.cornerRadius = 8
        copyButton.layer.borderWidth = 1
        copyButton.layer.backgroundColor = buttonColour.cgColor
        
        favouriteButton.backgroundColor = .clear
        favouriteButton.layer.cornerRadius = 8
        favouriteButton.layer.borderWidth = 1
        favouriteButton.layer.backgroundColor = buttonColour.cgColor
        
        shareButton.backgroundColor = .clear
        shareButton.layer.cornerRadius = 8
        shareButton.layer.borderWidth = 1
        shareButton.layer.backgroundColor = buttonColour.cgColor
    }
    
    
    
}
