//
//  Notify.swift
//  Teamup
//
//  Created by Aziz on 2018-03-06.
//  Copyright © 2018 Azizulla. All rights reserved.
//

import Foundation
import FirebaseDatabase
import UIKit

class Notify{
    

    var fromUid: String?
    var toUid: String?
    var eventUid: String?
    var stats: String?
    var uid: String?
  
    
    
    
    init(fromUid: String, toUid: String, eventUid: String, stats: String, uid: String) {
        
        //self.teamName = teamName
       self.fromUid = fromUid
        self.toUid = toUid
        self.eventUid = eventUid
        self.stats = stats
        self.uid = uid
    }
    
    init(snapshot: DataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        fromUid = snapshotValue["fromUid"] as? String
        toUid = snapshotValue["toUid"] as? String
        eventUid = snapshotValue["eventUid"] as? String
        stats = snapshotValue["stats"] as? String
        uid = snapshotValue["uid"] as? String
      
    }
    
    
}
