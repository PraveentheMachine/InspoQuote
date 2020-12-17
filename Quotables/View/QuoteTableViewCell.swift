//
//  QuoteTVC.swift
//  Quotables
//
//  Created by Praveen Bandarage on 3/12/20.
//

import UIKit

//Protocol which delegates functionality when buttons are pressed in the QuoteTableViewController
protocol QuoteTableViewCellDelegate: AnyObject {
    func didTapCopyButton(with quoteText: String, with authorName: String)
    func didTapFavouriteButton(with quoteText: String, with authorText: String)
    func didTapShareButton(with quoteText: String, with authorText: String)
}


class QuoteTableViewCell: UITableViewCell {

    weak var delegate: QuoteTableViewCellDelegate?
    
    
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
    
    
    //Method which calls delegate in QuoteTableViewController that saves a quote favourited by the user persistently!
    
    @IBAction func favouriteButtonPressed(_ sender: UIButton){
        delegate?.didTapFavouriteButton(with: quoteLabel.text!, with: authorLabel.text!)
    }
    //Method which calls delegate in QuoteTableViewController that opens a shareable popup for the user
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        delegate?.didTapShareButton(with: quoteLabel.text!, with: authorLabel.text!)
    }
    
    //Method which copies the quote and author to the clipboard, for pasting!
    @IBAction func copyButtonPressed(_ sender: UIButton) {
        delegate?.didTapCopyButton(with: quoteLabel.text!, with: authorLabel.text!)
    }
    
    
    //Method which handles the setting up of all buttons
    func setupMethod () {
        //Check if the buttons are not nil
        if copyButton != nil{
            //My styling for each button --> Could implement in cell method double check lmao 
            
            copyButton.backgroundColor = .clear
            copyButton.layer.cornerRadius = 8
            copyButton.layer.borderWidth = 1
            copyButton.layer.backgroundColor = Statics.defaultPurpleColour.cgColor
            
            favouriteButton.backgroundColor = .clear
            favouriteButton.layer.cornerRadius = 8
            favouriteButton.layer.borderWidth = 1
            favouriteButton.layer.backgroundColor = Statics.defaultPurpleColour.cgColor
            
            
            shareButton.backgroundColor = .clear
            shareButton.layer.cornerRadius = 8
            shareButton.layer.borderWidth = 1
            shareButton.layer.backgroundColor = Statics.defaultPurpleColour.cgColor
            
            //Making it so that buttons have a little animation when pressed
            favouriteButton.addTarget(self, action: #selector(self.animateButton(sender:)), for: .touchUpInside)
            shareButton.addTarget(self, action: #selector(self.animateButton(sender:)), for: .touchUpInside)
            copyButton.addTarget(self, action: #selector(self.animateButton(sender:)), for: .touchUpInside)
            
        }
    }
    
    //Method for calling animate button
    @objc private func animateButton(sender: UIButton){
        self.animateView(sender)
    }
    
    //Animation logic
    fileprivate func animateView(_ viewToAnimate: UIView){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations:  {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) {  (_) in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            }, completion: nil)
            
        }
    }
}
