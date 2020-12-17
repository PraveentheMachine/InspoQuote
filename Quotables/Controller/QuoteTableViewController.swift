//
//  QuoteTableViewController.swift
//  Quotables
//
//  Created by Praveen Bandarage on 3/12/20.
//

import UIKit
import RealmSwift
import AVFoundation

class QuoteTableViewController : UIViewController{
    
    
    @IBOutlet weak var quoteTableView: UITableView!
    
    let realm = try! Realm()
    var itemList : Results<FavouritedQuote>?
    var quoteListFinal = [FavouritedQuote]()
    
    var quoteList = [Quote]()
    let quoteManager = QuoteManger()
    

 
    
    
    
    
    override func viewDidLoad() {
        setup()
        
    }

//Stylistic choice to have viewdidLoad not jam packed with random things
func setup(){
    
    quoteTableView.backgroundColor = Statics.defaultPurpleColour
    
//    print(Realm.Configuration.defaultConfiguration.fileURL!) --> Way to check if its saved!
    
    //Loading the itemlist so that I can check if we already have the quote favourited, before favouriting, (avoiding duplicates)
    itemList = realm.objects(FavouritedQuote.self)
    
    //Hiding the back button because it looks untidy
    self.navigationItem.setHidesBackButton(true, animated: true)
    self.navigationItem.title = "Home"
    
    //Calling the quote manager to retrieve the quotes
    quoteManager.getQuotes()
    
    //Stop-gap solution for handling the JSON taking time to load, will stay in loop till quotes are loaded from the QuoteManager.
    
    while(quoteList.count == 0){
        quoteList = quoteManager.quoteList
        
    }
    
    //Shuffling quotes
    quoteList.shuffle()
    
    //Standard setup
    super.viewDidLoad()
    quoteTableView.dataSource = self
    
    //design adjustments
    quoteTableView.separatorStyle = .none
    quoteTableView.showsVerticalScrollIndicator = false
    quoteTableView.delegate = self
}
}

//TableView setup
extension QuoteTableViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = quoteTableView.dequeueReusableCell(withIdentifier: "quoteCell") as! QuoteTableViewCell
        
        //Setting values
        cell.quoteLabel.text = quoteList[indexPath.row].quote
        cell.authorLabel.text = quoteList[indexPath.row].author
        

        
        //giving cell rounded view
        cell.quoteView.layer.cornerRadius = cell.quoteView.frame.height / 8
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.delegate = self
        return cell
    }
    
    
}
//Extension to handle button interactions thriugh delegation
extension QuoteTableViewController: QuoteTableViewCellDelegate{
    
    //When we tap the share button I mimicked the standard sharing option screen, you see on apps like Reddit.
    func didTapShareButton(with quoteText: String, with authorText: String) {
    let stringToShare = "\(quoteText) - \(authorText)"
    let activityViewController = UIActivityViewController(activityItems: [stringToShare], applicationActivities: nil)
        
    activityViewController.popoverPresentationController?.sourceView = self.view
    self.present(activityViewController, animated: true, completion: nil)
    }
    
    

    //If we hit the copy button we copy the text
    func didTapCopyButton (with quoteText: String, with authorText: String) {
    UIPasteboard.general.string = "\(quoteText) - \(authorText)"
        
//Possible Adjustment in the future, lets SIRI read the quotes, kinda cringe atm cause it sounds weird, will need to ask friends if they prefer this over having a copy button
        
//        var speechSynthesizer = AVSpeechSynthesizer()
//        var speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: "\(quoteText) by \(authorText)")
//        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
//        speechSynthesizer.speak(speechUtterance)
    }
    //If we hit the favourite button we need to Persistently save the data on to the device
    func didTapFavouriteButton(with quoteText: String, with authorText: String) {
        
        //Trying to save using Realm
            do{
                
            try realm.write{
                
                //Setting up the quote
                let quoteToBeSaved  = FavouritedQuote()
                quoteToBeSaved.author = authorText
                quoteToBeSaved.quote = quoteText
                //All quotes are motivational in the future I might need to change this
                quoteToBeSaved.typeOfQuote = "Motivational"
                
                let quoteCheck = itemList?.filter("quote CONTAINS[cd] %@",quoteText)
                //Checking if we have the quote within the itemlist by querying the item list.
                if(quoteCheck?.count == 0){
//                print("We do not have the quote already")
                realm.add(quoteToBeSaved)
                
                }
                //If we already have the quote we do not to do anything atm
                else{
//                    print("We got the quote already")
                }
            }
            }
            catch{
                print("ERROR WRITING Quote \(error)")
        
            }
        }
    }



    
    
    
    

    
    



