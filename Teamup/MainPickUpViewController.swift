//
//  MainPickUpViewController.swift
//  Teamup
//
//  Created by Aziz on 2018-03-02.
//  Copyright © 2018 Azizulla. All rights reserved.
//


import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth


class MainPickUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var selectedTeam: PickUp!
    
    var pickUp = [PickUp]()
    var ref:DatabaseReference?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataSearchButton: UIButton!
    @IBOutlet weak var noDataLabel: UILabel!
    
    
   @IBAction func unwindToPickUp(segue:UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.layer.cornerRadius = 35.0
        
        ref = Database.database().reference()
        
        startObservingDatabase()
        
        
    }
    
    
    
    func startObservingDatabase () {
        //  let currentPlayer = selectedPost["uid"] as? String
        let userID = Auth.auth().currentUser?.uid
        print(userID!)
       // let currenTeam = selectedTeam.pickUpUid
        
        ref?.child("Players").child(userID!).child("PickUp").observe(.value, with: { (snapshot) in

            var newItems = [PickUp]()
            
            for itemSnapShot in snapshot.children {
                
                let item = PickUp(snapshot: itemSnapShot as! DataSnapshot)
                newItems.append(item)
             //   print(item.pickUpName!, "testing pickup")
            }
            
            self.pickUp = newItems
            self.tableView.reloadData()
 
        })
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        var numberOfSection: Int = 0
        if pickUp.count > 0{
            
            tableView.separatorStyle = .singleLine
            numberOfSection = 1
            //tableView.backgroundView = nil
            tableView.isHidden = false
            
            noDataSearchButton.isHidden = true
            noDataLabel.isHidden = true
            
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
        
        // return 1
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pickUp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPickUp", for: indexPath) as? MainPickupCell
        // var cell = UITableViewCell(style: .default, reuseIdentifier:"cell")
        
        let object = pickUp[indexPath.row]
       // cell?.pickupName?.text = object.pickUpUid
       
        ref?.child("PickUp").observe(.value, with: { (snapshot) in
          //  var newItems = [PickUp]()
            
            for itemSnapShot in snapshot.children {
                let item = PickUp(snapshot: itemSnapShot as! DataSnapshot)
                
                if object.pickUpUid == item.pickUpUid{
                    cell?.pickupName.text = item.pickUpName
                    cell?.pickupLocation.text = item.eventDate
                    
                } else {print("error pickup list")}
            }
  
        })
 
        
        return cell!

    }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "myPickUpProfile"{
            
            let navigationController = segue.destination as! UINavigationController
            let detailVC = navigationController.topViewController as! PickUpProfileViewController
            let indexPath = tableView.indexPathForSelectedRow
            
          
            
            detailVC.selectedPost = pickUp[(indexPath?.row)!]
                    }
        
    }


}
