//
//  Quote.swift
//  Quotables
//
//  Created by Praveen Bandarage on 1/12/20.
//

import Foundation
import UIKit

struct quoteContainer : Decodable{
    
    let quoteContainer: Quotes
    
}

struct Quotes : Decodable{
    let Quotes: [Quote]
}

struct Quote: Decodable, Equatable {
    let author: String
    let quote: String
    static func == (lhs: Quote, rhs: Quote) -> Bool {
            return
                lhs.author == rhs.author &&
                lhs.quote == rhs.quote

        }
}
