//
//  NotifictaionViewController.swift
//  Teamup
//
//  Created by Aziz on 2018-03-06.
//  Copyright © 2018 Azizulla. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth


class NotifictaionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var selectedTeam: Notify!
    
    var notify = [Notify]()
    var from = [Notify]()
    
    
    var ref:DatabaseReference?
    
    @IBOutlet weak var tableView: UITableView!

    
    
    @IBAction func unwindToPickUp(segue:UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        startObservingDatabase()
        
        

    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func startObservingDatabase () {
        //  let currentPlayer = selectedPost["uid"] as? String
        let userID = Auth.auth().currentUser?.uid
        print(userID!)
        
        ref?.child("Players").child(userID!).child("Notify").child("Recieve").observe(.value, with: { (snapshot) in
            
            var newItems = [Notify]()
            
            for itemSnapShot in snapshot.children {
                
                let item = Notify(snapshot: itemSnapShot as! DataSnapshot)
                newItems.append(item)
            }
            
            self.notify = newItems
           // self.tableView.reloadData()
            
        })
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
     /*   var numberOfSection: Int = 0
        if players.count > 0{
            
            tableView.separatorStyle = .singleLine
            numberOfSection = 1
            //tableView.backgroundView = nil
            tableView.isHidden = false
            
           // noDataSearchButton.isHidden = true
           // noDataLabel.isHidden = true
            
        } else {
            
            noDataSearchButton.isHidden = false
            noDataLabel.isHidden = false
            noDataLabel.text = "no data available"
            noDataLabel.textAlignment = .center
            
            tableView.isHidden = true
            
            // tableView.backgroundView = noDataLabel
            //tableView.separatorStyle = .none
            
        }
        
        return numberOfSection
        */
         return 1
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notify.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myNotification", for: indexPath) as? NotificationRequestCell

        
        let object = notify[indexPath.row]
        cell?.messageLabel.text = "Player would love to join your team"
        cell?.configureCell(quote: object)
        cell?.delegate = self
        
// getting sender info
        ref?.child("Players").child(object.fromUid!).observe(.value, with: { (snapshot) in
                
                let item = Players(snapshot: snapshot )
              //  cell?.playerNameLabel.text = item.firstName
  
            
        })

        
        return cell!
        // return configureCell(cell, at: indexPath)
    }
    
}



extension NotifictaionViewController: MyCellDelegate {
    
    func acceptButtonTapped(_ sender: NotificationRequestCell) {
        guard let tappedIndex = tableView.indexPath(for: sender) else {return}
        print("LIKE")
        
        sender.accept.setTitle("accepted", for: .normal)
        
// getting sender info
        ref?.child("Players").observe(.value, with: { (snapshot) in
            //self.ref?.child("Players").child(sender.toUid!).child("Notify").child("Recieve").child(sender.eventUid!).removeValue()
            //self.ref?.child("Players").child(sender.senderUID!).child("Notify").child("Send").child(sender.eventUid!).removeValue()

               // self.tableView.reloadData()
            if snapshot.hasChild(sender.senderUID!) {
                for itemSnapShot in snapshot.children {
                    let item2 = Players(snapshot: itemSnapShot as! DataSnapshot)
                    
                    if sender.senderUID == item2.uid {
                        
                        self.ref?.child("Players").child(sender.toUid!).child("Notify").child("Recieve").child(sender.eventUid!).removeValue()
                        self.ref?.child("Players").child(sender.senderUID!).child("Notify").child("Send").child(sender.eventUid!).removeValue()
                    } else { print("could not find the player")}
                }}
        })

// getting Event info
        self.ref?.child("Team").observe(.value, with: { (snapshot) in
            
            if snapshot.hasChild(sender.eventUid!) {
                for itemSnapShot in snapshot.children {
                    let item2 = Team(snapshot: itemSnapShot as! DataSnapshot)
                    
                    if sender.eventUid == item2.teamUid {
                    self.ref?.child("Players").child(sender.senderUID!).child("Team").child(sender.eventUid!).child("teamUid").setValue(sender.eventUid)
                        self.ref?.child("Team").child(sender.eventUid!).child("player").child(sender.senderUID!).child("uid").setValue(sender.senderUID!)
                        
                    } else { print("no match teamUid")}
                    
                }
                
            } else {
             
             self.ref?.child("PickUp").observe(.value, with: { (snapshot) in
             
             if snapshot.hasChild(sender.eventUid!){
                for itemSnapShot in snapshot.children {
                    let item = PickUp(snapshot: itemSnapShot as! DataSnapshot )
             
             
                        if sender.eventUid == item.pickUpUid {
                            self.ref?.child("Players").child(sender.senderUID!).child("PickUp").child(sender.eventUid!).child("teamUid").setValue(sender.eventUid)
                            self.ref?.child("PickUp").child(sender.eventUid!).child("player").child("uid").setValue(sender.senderUID!)
                
                        } else { print("pickup not matched child")}
                }
             } else {print("pickup not matched")}
             
             })
             
             }
        })
    }
    
    func rejectButtonTapped(_ sender: NotificationRequestCell) {
        guard let tappedIndex = tableView.indexPath(for: sender) else {return}
        print("LOVE", sender, tappedIndex)
        sender.reject.setTitleColor(.orange, for: .normal)
    }

    
   
}
