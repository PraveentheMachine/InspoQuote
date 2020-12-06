//
//  Favourites.swift
//  Quotables

// Class which persistently stores the data of the favourites and the
//  Created by Praveen Bandarage on 1/12/20.
//

import Foundation
import UIKit

class Favourites : UITableViewController{
    
    
    override func viewDidLoad() {
//        self.navigationItem.setHidesBackButton(true, animated: true)

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    //

}
