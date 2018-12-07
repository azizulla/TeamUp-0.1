//
//  MainTeamCell.swift
//  Teamup
//
//  Created by Azizullla Yousufi on 2018-11-29.
//  Copyright © 2018 Azizulla. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class MainTeamCell: UITableViewCell {
    
    var selectedTeam: Team!
    
    var ref:DatabaseReference?
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var tagLine: UILabel!
    
    
    @IBOutlet weak var teamLogo: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.teamLogo.layer.cornerRadius = 10
        self.teamLogo.clipsToBounds = true
    }
    
    
    
}
