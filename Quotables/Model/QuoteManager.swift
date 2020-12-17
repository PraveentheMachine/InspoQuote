//
//QuoteManager.swift
//InspoQuote
//Handles the interactions with the API and Networking aspects of the code
//Created by Praveen Bandarage on 1/12/20.
//

import Foundation

class QuoteManger{
    var quoteList = [Quote]()
    let quoteURL = "https://praveenthemachine.github.io/quotes.json" //JSON hosting link
    
    //Method which gets the quotes from quotes.json file hosted on GitHub and processes them
    func getQuotes(){
        //Optionaly binding URL constant
        if let url = URL(string: quoteURL){
            //Creates URL session object (like a browser)
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, Response, error) in
                if error != nil {
                    print("ERROR WRITING \(String(describing: error))")
                    return
                }
      
                    if let safeData = data{
                        self.parseJSON(quoteData: safeData)
                    }
                
                }
            task.resume()
            //starting the task
        }
        }


    
    //Method for parsing JSON into quote
    func parseJSON (quoteData: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(quoteContainer.self, from: quoteData)
            self.quoteList = decodedData.quoteContainer.Quotes
            }
        catch{
            print("ERROR \(error)")
            
        }
       
}
}

