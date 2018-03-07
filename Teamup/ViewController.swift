//
//  ViewController.swift
//  Teamup
//
//  Created by Aziz on 2018-03-02.
//  Copyright © 2018 Azizulla. All rights reserved.
//
/*

ref?.child("Team").observe(.value, with: { (snapshot) in
    
    
    if snapshot.hasChild(object.eventUid!){
        
        // if object.eventUid == item.teamUid{
        for itemSnapShot in snapshot.children {
            let item = Team(snapshot: itemSnapShot as! DataSnapshot )
            print("match team")
            
            
            cell?.playerNameLabel.text = item.teamName
        }
        
    } else { print("not match team")
        
        self.ref?.child("PickUp").observe(.value, with: { (snapshot) in
            
            
            if snapshot.hasChild(object.eventUid!){
                for itemSnapShot in snapshot.children {
                    
                    let item = PickUp(snapshot: itemSnapShot as! DataSnapshot )
                    
                    cell?.playerNameLabel.text = item.pickUpName
                    print("pickup matched")
                    
                    
                    
                }
            } else {print("pickup not matched")}
            
        })
        
    }
    
    
})

*/
