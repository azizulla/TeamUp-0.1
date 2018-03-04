//
//  PickUp.swift
//  Teamup
//
//  Created by Aziz on 2018-03-02.
//  Copyright © 2018 Azizulla. All rights reserved.
//

import Foundation
import FirebaseDatabase
import UIKit

class PickUp{
    
    var ref:DatabaseReference?
    
    var pickUpName: String?
    var squadSize: String?
    var author: String?
    
    var pickUpUid: String?
    var kitColor: String?
    var eventDate: String?
    var eventTime: String?
    var price: String?
    
    
    init(pickUpName: String, squadSize: String, author: String, pickUpUid: String, kitColor: String, eventDate: String, eventTime: String, price: String) {
        
        self.pickUpName = pickUpName
        self.squadSize = squadSize
        self.author = author
        self.pickUpUid = pickUpUid
        self.kitColor = kitColor
        self.eventDate = eventDate
        self.eventTime = eventTime
        self.price = price
        
        
    }
    
    init(snapshot: DataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        pickUpName = snapshotValue["name"] as? String
        squadSize = snapshotValue["squad"] as? String
        author = snapshotValue["author"] as? String
        pickUpUid = snapshotValue["teamUid"] as? String
        kitColor = snapshotValue["jerseyColor"] as? String
        eventTime = snapshotValue["eventTime"] as? String
        eventDate = snapshotValue["eventDate"] as? String
        price = snapshotValue["price"] as? String
        
        ref = snapshot.ref
    }
    
    
}


