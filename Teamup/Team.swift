//
//  Team.swift
//  Teamup
//
//  Created by Aziz on 2018-03-02.
//  Copyright © 2018 Azizulla. All rights reserved.
//

import Foundation
import FirebaseDatabase
import UIKit

class Team{
    
    var ref:DatabaseReference?
    var teamName: String?
    var squad: String?
    var author: String?
    
    var teamUid: String?
    var players: String?
    
    
    
    init(teamName: String, squad: String, author: String,players: String,teamUid: String) {
        
        self.teamName = teamName
        self.squad = squad
        self.author = author
        self.ref = nil
        
        self.teamUid = teamUid
        self.players = players
    }
    
    init(snapshot: DataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        teamName = snapshotValue["name"] as? String
        squad = snapshotValue["squad"] as? String
        author = snapshotValue["author"] as? String
        teamUid = snapshotValue["teamUid"] as? String
        
        players = snapshotValue["player"] as? String
        

        
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return ["name":teamName as AnyObject,
                "squad":squad as AnyObject,
                "player":players as AnyObject,
                "author":author as AnyObject]    }
    
    
}

