//
//  QuoteTableViewController.swift
//  Quotables
//
//  Created by Praveen Bandarage on 3/12/20.
//

import UIKit
import SkeletonView
import RealmSwift

class QuoteTableViewController : UIViewController{
    
    
    @IBOutlet weak var quoteTableView: UITableView!
    
    let realm = try! Realm()
    var itemList : Results<FavouritedQuote>?
    var quoteListFinal = [FavouritedQuote]()
    
    var quoteList = [Quote]()
    let quoteManager = QuoteManger()
    let gradient = SkeletonGradient(baseColor: UIColor.wisteria)
    
    
    //
    
    
    
    override func viewDidLoad() {
        quoteTableView.backgroundColor = UIColor(red: 0.19, green: 0.20, blue: 0.42, alpha: 1.00)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        itemList = realm.objects(FavouritedQuote.self)
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "Home"
        quoteManager.getQuotes()
        while(quoteList.count == 0){
            quoteList = quoteManager.quoteList
            
        }
        quoteList.shuffle()
        super.viewDidLoad()
        quoteTableView.dataSource = self
        //design adjustments
        quoteTableView.separatorStyle = .none
        quoteTableView.showsVerticalScrollIndicator = false
        quoteTableView.delegate = self
        
    }
}

extension QuoteTableViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = quoteTableView.dequeueReusableCell(withIdentifier: "quoteCell") as! QuoteTableViewCell
        
        let quoteText = quoteList[indexPath.row].quote
        cell.quoteLabel.text = quoteText
        cell.authorLabel.text = quoteList[indexPath.row].author
        
        //giving cell rounded view
        cell.quoteView.layer.cornerRadius = cell.quoteView.frame.height / 8
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        //        cell.isSkeletonable = true
        //        cell.showAnimatedGradientSkeleton()
        cell.delegate = self
        return cell
    }
    
    
}

extension QuoteTableViewController: QuoteTableViewCellDelegate{
    func didTapShareButton(with quoteText: String, with authorText: String) {
        print(quoteText)
        print(authorText)
        
        let stringToShare = "\(quoteText) - \(authorText)"
        let activityViewController = UIActivityViewController(activityItems: [stringToShare], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func didTapCopyButton (with quoteText: String, with authorText: String) {
        UIPasteboard.general.string = "\(quoteText) - \(authorText)"
        
    }
    
//    func objectExist (id: String) -> Bool {
//            return realm.object(ofType: FavouritedQuote.self, forPrimaryKey: id) != nil
//    }

    
    func didTapFavouriteButton(with quoteText: String, with authorText: String) {
        
  
            do{
            try realm.write{
                let quoteToBeSaved  = FavouritedQuote()
                quoteToBeSaved.author = authorText
                quoteToBeSaved.quote = quoteText
                quoteToBeSaved.typeOfQuote = "Motivational"
                let objectB = itemList?.filter("quote CONTAINS[cd] %@",quoteText)
                if(objectB?.count == 0){
                    print("WE DO NOT GOT IT ALREADY")
                realm.add(quoteToBeSaved)
                
                }
                else{
                    print("WE GOT IT ALREADY")
                }
            }
            }
            catch{
                print("ERROR WRITING \(error)")
        
            }
        }
    }


    
    
    
    

    
    



