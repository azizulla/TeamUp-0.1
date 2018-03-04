//
//  Players.swift
//  Teamup
//
//  Created by Aziz on 2018-03-02.
//  Copyright © 2018 Azizulla. All rights reserved.
//

import Foundation
import FirebaseDatabase


class Players: NSObject{
    
    var ref:DatabaseReference?
    // let ownedPartiesKeys: [String: Any]?
    // let attendingPartiesKeys: [String: Any]?
    
    var email: String?
    
    var firstName: String?
    var lastName: String?
    var gender: String?
    var phone: String?
    var position: String?
    
    var kitNumber: String?
    
    var uid: String!
    var profileImageUrl: String?
    var teamplayer = [Team]()
    
    //  var favorite: String
    
    init(firstName: String, lastName: String, email: String, position: String, userID: String, teamplayer: [Team], profileImageUrl: String, gender: String, kitNumber: String) {
        
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = position
        self.position = position
        self.gender = gender
        self.kitNumber = kitNumber
        
        
        self.profileImageUrl = profileImageUrl
        self.uid = userID
        self.ref = nil
        
        
    }
    
    init(snapshot: DataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        firstName = snapshotValue["firstName"] as? String
        lastName = snapshotValue["lastName"] as? String
        email = snapshotValue["email"] as? String
        position = snapshotValue["position"] as? String
        uid = snapshotValue["uid"] as? String
        gender = snapshotValue["gender"] as? String
        phone = snapshotValue["phone"] as? String
        profileImageUrl = snapshotValue["profileImageUrl"] as? String
        kitNumber = snapshotValue["kitNumber"] as? String
        
        ref = snapshot.ref
    }
    
    
}


