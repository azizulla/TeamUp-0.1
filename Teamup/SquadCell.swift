//
//  SquadCell.swift
//  Teamup
//
//  Created by Azizullla Yousufi on 2018-12-06.
//  Copyright © 2018 Azizulla. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class SquadCell: UITableViewCell {
    
    var selectedTeam: Team!
    
    var ref:DatabaseReference?
    
    
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerPosition: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.teamLogo.layer.cornerRadius = 10
        self.teamLogo.clipsToBounds = true
    }
    
    
    
}
