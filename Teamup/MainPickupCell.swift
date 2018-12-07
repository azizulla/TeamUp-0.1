//
//  MainPickupCell.swift
//  Teamup
//
//  Created by Azizullla Yousufi on 2018-11-29.
//  Copyright © 2018 Azizulla. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MainPickupCell: UITableViewCell {
    
    var selectedTeam: Team!
    
    var ref:DatabaseReference?
    @IBOutlet weak var pickupName: UILabel!
    @IBOutlet weak var pickupLocation: UILabel!
    
    
    @IBOutlet weak var pickupLogo: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.pickupLogo.layer.cornerRadius = 10
        self.pickupLogo.clipsToBounds = true
    }
    
    
    
    
}
