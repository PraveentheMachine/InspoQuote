//
//FavouritedQuote.swift
//InspoQuote
//Created by Praveen Bandarage on 1/12/20.
//
//

import Foundation
import RealmSwift


//Persistently stored object known as a Favourited Quote, contains a type of quote variable --> in the future I will implement a third view controller which handles this aspect and divides quotes into different classes, e.g: Happy, Sad, Motivational, etc.
class FavouritedQuote: Object {
    @objc dynamic var author : String = ""
    @objc dynamic var quote : String = ""
    @objc dynamic var typeOfQuote : String = ""


     static func == (lhs: FavouritedQuote, rhs: FavouritedQuote) -> Bool {

        return lhs.author == rhs.author && lhs.quote == rhs.quote
        }
    

}
