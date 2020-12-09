//
//  Favourites.swift
//  Quotables

// Class which persistently stores the data of the favourites and the
//  Created by Praveen Bandarage on 1/12/20.
//

import Foundation
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
    
    /**
     Method used for setting up Favourite Table view controller, this is primarily a preference to remove all I can from the viewDidLoad method
     */
    
    func setupMethod(){
        self.navigationItem.title = "Favourites"
        
        favouriteQuoteTableView.reloadData()
        favouriteQuoteTableView.dataSource = self
        favouriteQuoteTableView.separatorStyle = .none
        favouriteQuoteTableView.showsVerticalScrollIndicator = false
        favouriteQuoteTableView.delegate = self
        favouriteQuoteTableView.rowHeight = 250
        favouriteQuoteTableView.backgroundColor = UIColor(red: 0.19, green: 0.20, blue: 0.42, alpha: 1.00)

    }
    /**
    Method which retrieves favourited quotes from Realm and places them in a container named favouritedQuoteList for retrieval
     */
    func loadFavouritedQuotes(){
        favouritedQuoteList = realm.objects(FavouritedQuote.self)
        favouriteQuoteTableView.reloadData()
        
    }
    
    /**
    As quotes are constantly added to the favouritedQuoteList in QuoteTableViewController it is important to reload the quotes as screens are switched
     */
    override func viewWillAppear(_ animated: Bool) {
        loadFavouritedQuotes()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritedQuoteList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Creating the Favourite Quote Cell
        let cell = favouriteQuoteTableView.dequeueReusableCell(withIdentifier: "favouritedQuoteCell") as! FavouriteQuoteTableViewCell
        
        //Setting the quote and author
        cell.quoteLabel.text =  favouritedQuoteList?[indexPath.row].quote
        cell.authorLabel.text = favouritedQuoteList?[indexPath.row].author
        
        //Giving the cell a rounded feel
        cell.quoteView.layer.cornerRadius = cell.quoteView.frame.height / 8
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
        
}
