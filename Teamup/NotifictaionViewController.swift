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
        
        ref?.child("Players").child(userID!).child("Notify").child("Send").observe(.value, with: { (snapshot) in
            
            var newItems = [Notify]()
            
            for itemSnapShot in snapshot.children {
                
                let item = Notify(snapshot: itemSnapShot as! DataSnapshot)
                newItems.append(item)
            }
            
            self.notify = newItems
            self.tableView.reloadData()
            
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
       // cell?.playerNameLabel.text = object.eventUid
        cell?.messageLabel.text = "Player would love to join your team"
        


// getting sender info
        ref?.child("Players").child(object.fromUid!).observe(.value, with: { (snapshot) in
                
                let item = Players(snapshot: snapshot )
          
              //  cell?.playerNameLabel.text = item.firstName
  
            
        })
        
        
// getting event info
        ref?.child("Team").observe(.value, with: { (snapshot) in
            
            if snapshot.hasChild(object.eventUid!) {

                for itemSnapShot in snapshot.children {
                    let item = Team(snapshot: itemSnapShot as! DataSnapshot)
                  
                    if object.eventUid == item.teamUid {
                        
                        cell?.playerNameLabel.text = item.teamName

                    } else { print("no match teamUid")}
                    
                }
                
            } else {

                self.ref?.child("PickUp").observe(.value, with: { (snapshot) in
                
                    if snapshot.hasChild(object.eventUid!){
                        for itemSnapShot in snapshot.children {
                            let item = PickUp(snapshot: itemSnapShot as! DataSnapshot )
                            
                            
                                if object.eventUid == item.pickUpUid {
                                cell?.playerNameLabel.text = item.pickUpName
                            
                                } else { print("pickup not matched child")}
                        }
                    } else {print("pickup not matched")}
                    
                })

            }
        })

        
        
        
        return cell!
        // return configureCell(cell, at: indexPath)
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
/*    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "myPickUpProfile"{
            
            let navigationController = segue.destination as! UINavigationController
            let detailVC = navigationController.topViewController as! PickUpProfileViewController
            let indexPath = tableView.indexPathForSelectedRow
            
            
            
            detailVC.selectedPost = pickUp[(indexPath?.row)!]
        }
        
    }
    */
    
}

