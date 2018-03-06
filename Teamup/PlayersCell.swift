//
//  PlayersCell.swift
//  Teamup
//
//  Created by Aziz on 2018-03-04.
//  Copyright © 2018 Azizulla. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class PlayersCell: UITableViewCell {
    
    var ref:DatabaseReference?
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /*
         self.layer.cornerRadius = self.frame.height / 2
         self.clipsToBounds = true
         
         profileImage.layer.cornerRadius = 10
         */
        self.profileImage.layer.cornerRadius = 10
        self.profileImage.clipsToBounds = true
    }
    
    
    
    @IBAction func playerInvitation(_ sender: Any) {
        
    }
}
