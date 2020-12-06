//
//  QuoteTableViewController.swift
//  Quotables
//
//  Created by Praveen Bandarage on 3/12/20.
//

import UIKit
import SkeletonView

class QuoteTableViewController : UIViewController{
    

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteTableView: UITableView!
    
    var quoteList = [Quote]()
    let quoteManager = QuoteManger()
    let gradient = SkeletonGradient(baseColor: UIColor.wisteria)

    
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var copyButtonPressed: UIButton!
    
    @IBAction func copyButtonPressed(_ sender: UIButton) {
        
        print(authorLabel.text!)
        print(quoteLabel.text!)
    }
    
    
    override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "Home"

        quoteTableView.isSkeletonable = true
        quoteManager.getQuotes()
        quoteTableView.showGradientSkeleton(usingGradient: gradient)
        quoteTableView.showSkeleton(transition: .crossDissolve(3))     //Show skeleton cross dissolve transition with 0.25 seconds fade time

        while(quoteList.count == 0){
            quoteList = quoteManager.quoteList

        }
        quoteTableView.isSkeletonable = false
        quoteTableView.stopSkeletonAnimation()
        quoteTableView.hideSkeleton(transition: .crossDissolve(3.25))     //Hide skeleton cross dissolve transition with 0.25 seconds fade time

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

extension QuoteTableViewController : UITableViewDataSource, UITableViewDelegate {
    
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
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
//        cell.isSkeletonable = true
//        cell.showAnimatedGradientSkeleton()

        return cell
    }
    
    
    
    
}


