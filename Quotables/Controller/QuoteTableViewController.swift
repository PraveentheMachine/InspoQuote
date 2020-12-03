//
//  QuoteTableViewController.swift
//  Quotables
//
//  Created by Praveen Bandarage on 3/12/20.
//

import UIKit

class QuoteTableViewController : UIViewController{
    

    @IBOutlet weak var quoteTableView: UITableView!
    
        var quoteList = [Quote]()
        let quoteManager = QuoteManger()

    override func viewDidLoad() {
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
//        quoteTableView.rowHeight = 250
    }
}

extension QuoteTableViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = quoteTableView.dequeueReusableCell(withIdentifier: "quoteCell") as! QuoteTVC
        
        let quoteText = quoteList[indexPath.row].quote
        cell.quoteLabel.text = quoteText
        cell.authorLabel.text = quoteList[indexPath.row].author
        
        //giving cell rounded view
        cell.quoteView.layer.cornerRadius = cell.quoteView.frame.height / 8
        return cell
    }
    
    
}
