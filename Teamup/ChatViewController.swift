//
//  ChatViewController.swift
//  Teamup
//
//  Created by Azizullla Yousufi on 2018-11-27.
//  Copyright © 2018 Azizulla. All rights reserved.
//
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

import Foundation

class ChatViewController: UITableViewController  {
    
    var players = [Players]()
    var ref:DatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        startObservingDatabase()
        
    }
   
    
    
    
    func startObservingDatabase () {
        ref?.child("Team").observe(.value, with: { (snapshot) in
            var newItems = [Players]()
            
            for itemSnapShot in snapshot.children {
                let item = Players(snapshot: itemSnapShot as! DataSnapshot)
                newItems.append(item)
            }
            
            self.players = newItems
            self.tableView.reloadData()
            
        })
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "playersCell", for: indexPath)
        // var cell = UITableViewCell(style: .default, reuseIdentifier:"cell")
        
        let object = players[indexPath.row]
        cell.textLabel?.text = object.firstName
        
        
        
        return cell
        // return configureCell(cell, at: indexPath)
    }

    
}
