////
////  FavouritedQuote.swift
////  Quotables
////
////  Created by Praveen Bandarage on 1/12/20.
////
//

import Foundation
import RealmSwift

class FavouritedQuote: Object {
    @objc dynamic var author : String = ""
    @objc dynamic var quote : String = ""
    @objc dynamic var typeOfQuote : String = ""


     static func == (lhs: FavouritedQuote, rhs: FavouritedQuote) -> Bool {

        return lhs.author == rhs.author && lhs.quote == rhs.quote
        }
    

}
