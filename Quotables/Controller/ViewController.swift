////
////  ViewController.swift
////  Quotables
////
////  Created by Praveen Bandarage on 1/12/20.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//    let quoteManager = QuoteManger()
//    var quoteList = [Quote]()
//    var quotesSeen = [Quote]()
//    
//    @IBOutlet weak var authorLabel: UILabel!
//    @IBOutlet weak var quoteLabel: UILabel!
//    
//    override func viewDidLoad() {
//        
//        super.viewDidLoad()
//        quoteManager.getQuotes()
//        print(quoteManager.quoteList)
//        //default values, I love this quote loading up when I get the app
//        quoteLabel.text = "Test"
//    
//        
//        }
//
//    @IBAction func nextQuoteButton(_ sender: UIButton) {
//        //if its the first time
//    
////        quoteField.text = quoteList[0].quote
//    }
//    
//    @IBAction func nextQuoteButtonPressed(_ sender: UIButton) {
//        quoteList = quoteManager.quoteList
//        var randomQuoteNumber = Int.random(in: 0...quoteList.count-1)
//        while quotesSeen.contains(quoteList[randomQuoteNumber]) {
//            randomQuoteNumber = Int.random(in: 0...quoteList.count-1)
//        }
//        authorLabel.text = quoteManager.quoteList[randomQuoteNumber].author
//        quoteLabel.text = quoteManager.quoteList[randomQuoteNumber].quote
//        quotesSeen.append(quoteList[randomQuoteNumber])
//        if(quotesSeen.count == quoteList.count){
//            quotesSeen.removeAll()
//        }
//
//    }
//    //Function for swiping between screen
//
//
//    //Function for favouriting
//    
//    //Function for sharing
//    
//    //Function for Copying the text
//}
//
