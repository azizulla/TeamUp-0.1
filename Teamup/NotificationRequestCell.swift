//
//  NotificationRequestCell.swift
//  Teamup
//
//  Created by Aziz on 2018-03-06.
//  Copyright © 2018 Azizulla. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class NotificationRequestCell: UITableViewCell {
    
    var ref:DatabaseReference?
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var accept: UIButton!
    @IBOutlet weak var reject: UIButton!
    
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
    
    
    
    @IBAction func acceptButton(_ sender: Any) {
        
    }
    
    @IBAction func rejectButton(_ sender: Any) {
        
    }
    
}

