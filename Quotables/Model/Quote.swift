//
//  Quote.swift
//  InspQuote
//
//  Created by Praveen Bandarage on 1/12/20.
//

import Foundation
import UIKit

//Struct for holding QuoteContainers which is over arching container for all of the quotes
struct quoteContainer : Decodable{
    let quoteContainer: Quotes
}
//Struct for holding the array of quotes
struct Quotes : Decodable{
    let Quotes: [Quote]
}
//A quote object which contains both an author and a message 
struct Quote: Decodable, Equatable {
    let author: String
    let quote: String
    
    static func == (lhs: Quote, rhs: Quote) -> Bool {
        //Equality check, if the author and the quote is the same, then we have the same quote 
        return
            lhs.author == rhs.author &&
            lhs.quote == rhs.quote
        
    }
}
