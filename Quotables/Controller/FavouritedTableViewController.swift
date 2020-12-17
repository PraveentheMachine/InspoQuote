//
//  Favourites.swift
//  Quotables

// Class which persistently stores the data of the favourites and the
//  Created by Praveen Bandarage on 1/12/20.
//

import UIKit
import RealmSwift


class FavouritedTableViewController : UITableViewController{
    //Persistence Information used for Storing Favourited Quotes
    let realm = try! Realm()
    var favouritedQuoteList : Results<FavouritedQuote>?
    @IBOutlet var favouriteQuoteTableView: UITableView!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupMethod()
        loadFavouritedQuotes()
    }
    
    //Method used for setting up Favourite Table view controller, this is primarily a preference to remove all I can from the viewDidLoad method
    
    func setupMethod(){
        self.navigationItem.title = "Favourites"
    
        favouriteQuoteTableView.reloadData()
        favouriteQuoteTableView.dataSource = self
        favouriteQuoteTableView.separatorStyle = .none
        favouriteQuoteTableView.showsVerticalScrollIndicator = false
        favouriteQuoteTableView.delegate = self
        favouriteQuoteTableView.rowHeight = 250
        favouriteQuoteTableView.backgroundColor = Statics.defaultPurpleColour

    }
    //Method which retrieves favourited quotes from Realm and places them in a container named favouritedQuoteList for retrieval
     
    func loadFavouritedQuotes(){
        favouritedQuoteList = realm.objects(FavouritedQuote.self)
        favouriteQuoteTableView.reloadData()
        
    }
    
    //Method for adding personal quotes, tied to the '+' button tied to the favourite view controller.
    @IBAction func addPersonalQuote(_ sender: Any) {
        
        print("Button Pressed")
        //The alert message
        let alert = UIAlertController(title: "Would you like to add your own quote?", message: "Feel free to add your own favourites quotes that you would like to save!", preferredStyle: .alert)
        
        //If a user does not want to add a qutoe give them the option to cancel
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

       //Textfields for both quote and author
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your quote here..."
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input the author here..."
        })
        
        //Adding the quote and then persistently saving the quote
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            let quote = alert.textFields?.first?.text
            let author = alert.textFields?[1].text
            if(!quote!.isEmpty && !author!.isEmpty){
             do{
                try self.realm.write{
                 let quoteToBeSaved  = FavouritedQuote()
                 quoteToBeSaved.quote = alert.textFields?.first?.text ?? ""
                 quoteToBeSaved.author = alert.textFields?[1].text! ?? ""
                 quoteToBeSaved.typeOfQuote = "Motivational"
                    self.realm.add(quoteToBeSaved)
                    self.tableView.reloadData()
             }
             }
             catch{
                 print("ERROR WRITING \(error)")
         
             }
            }}))
        

        self.present(alert, animated: true)
            
    }
   
    //When the view is being transitioned to we need to reload our favourites quotes as they are constantly being updated
    override func viewWillAppear(_ animated: Bool) {
        loadFavouritedQuotes()
    }
    
    //Setting number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritedQuoteList?.count ?? 0
    }
    
    //Defining cells in Favourite Table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Creating the Favourite Quote Cell
        let cell = favouriteQuoteTableView.dequeueReusableCell(withIdentifier: "favouritedQuoteCell") as! FavouriteQuoteTableViewCell
        
        //Setting the quote and author
        cell.quoteLabel.text =  favouritedQuoteList?[indexPath.row].quote
        cell.authorLabel.text = favouritedQuoteList?[indexPath.row].author
        
        //Giving the cell a rounded feel
        cell.quoteView.layer.cornerRadius = cell.quoteView.frame.height / 8
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.delegate = self
        return cell
    }
    
    //For deletion when swiping to the left, begin the deletion process at the current row at the table view
     override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //Deletion with realm handling
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            //Nifty trick, because this is using Realm and deletion is occuring in Tableview, I cannot simply just delete the row and then reload, this crashes the program
            favouriteQuoteTableView.beginUpdates()
            
            //Checking to see if quote exists and if so delete
            if let quoteToDelete = favouritedQuoteList?[indexPath.row]{
            do{
                try self.realm.write{
                    self.realm.delete(quoteToDelete)
            }
            }
                catch{
                    print("FAILED to Delete")
                }
            }
            
            //Adding faded effect
            favouriteQuoteTableView.deleteRows(at: [indexPath], with: .fade)
            favouriteQuoteTableView.endUpdates()
        }
    }
        
}


//Extension for handling sharing Quotes --> Todo: DRY need to find a way to handle this with other quotes
extension FavouritedTableViewController: FavouriteQuoteTableViewCellDelegate{
    func didTapShareButton(with quoteText: String, with authorText: String) {
                  let stringToShare = "\(quoteText) - \(authorText)"
                  let activityViewController = UIActivityViewController(activityItems: [stringToShare], applicationActivities: nil)
        
              activityViewController.popoverPresentationController?.sourceView = self.view
              self.present(activityViewController, animated: true, completion: nil)
    }
    
    
}

