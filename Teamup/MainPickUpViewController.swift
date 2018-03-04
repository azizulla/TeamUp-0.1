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
    
    var selectedTeam: Team!
    
    var pickUp = [PickUp]()
    var ref:DatabaseReference?
    
    @IBOutlet weak var tableView: UITableView!
   @IBAction func unwindToPickUp(segue:UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        startObservingDatabase()
        
    }
    
    
    
    func startObservingDatabase () {
        //  let currentPlayer = selectedPost["uid"] as? String
        let userID = Auth.auth().currentUser?.uid
        print(userID!)
        
        ref?.child("Players").child(userID!).child("PickUp").observe(.value, with: { (snapshot) in
           
            print("testing 3")
            var newItems = [PickUp]()
            
            for itemSnapShot in snapshot.children {
                
                let item = PickUp(snapshot: itemSnapShot as! DataSnapshot)
                newItems.append(item)
                print(item.pickUpName!, "testing pickup")
            }
            
            self.pickUp = newItems
            self.tableView.reloadData()
            
        })
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pickUp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPickUp", for: indexPath)
        // var cell = UITableViewCell(style: .default, reuseIdentifier:"cell")
        
        let object = pickUp[indexPath.row]
        cell.textLabel?.text = object.pickUpName
        
        
        return cell
        // return configureCell(cell, at: indexPath)
    }
    

}
