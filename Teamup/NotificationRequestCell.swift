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

protocol MyCellDelegate {
    func acceptButtonTapped(_ sender: NotificationRequestCell)
    func rejectButtonTapped(_ sender: NotificationRequestCell)
   
}

class NotificationRequestCell: UITableViewCell {
    
    var ref:DatabaseReference?
    var notify = [Notify]()
    
    
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
    
    var delegate: MyCellDelegate?
    var senderUID : String?
    var eventUid : String?
    var toUid : String?
    
    func configureCell(quote: Notify){
      //  print(quote.eventUid ?? "aziz")
        messageLabel.text = quote.eventUid
        delegate?.acceptButtonTapped(self)
        
        notify = [quote]
        senderUID = quote.fromUid
        eventUid = quote.eventUid
        toUid = quote.toUid
        ref?.child("aziz").setValue(quote.eventUid)
    }
    
    @IBAction func acceptButton(_ sender: Any) {
   print("accept")
        delegate?.acceptButtonTapped(self)
    }
    
    @IBAction func rejectButton(_ sender: Any) {
        print("reject")
        delegate?.rejectButtonTapped(self)
    }
    
}


