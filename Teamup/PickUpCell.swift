//
//  PickUpCell.swift
//  Teamup
//
//  Created by Aziz on 2018-03-02.
//  Copyright © 2018 Azizulla. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class PickUpCell: UITableViewCell {
    
    var ref:DatabaseReference?
    @IBOutlet weak var pickUpName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    @IBAction func joinPickUp(_ sender: Any) {
        
    }
}

