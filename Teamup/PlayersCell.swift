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
    
    var selectedTeam: Team!
    
    var ref:DatabaseReference?
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.profileImage.layer.cornerRadius = 10
        self.profileImage.clipsToBounds = true
    }
    
    
    
    @IBAction func playerInvitation(_ sender: Any) {
        //self.ref?.child("Players").child(sender.senderUID!).child("Team").child(sender.eventUid!).child("teamUid").setValue(sender.eventUid)
        //self.ref?.child("Team").child(sender.eventUid!).child("player").child(sender.senderUID!).child("uid").setValue(sender.senderUID!)
    }
}
