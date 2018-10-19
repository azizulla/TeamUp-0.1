//
//  TeamSquadListViewController.swift
//  Teamup
//
//  Created by Aziz on 2018-03-02.
//  Copyright © 2018 Azizulla. All rights reserved.
//


import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth


class TeamSquadListViewController: UITableViewController  {
    
    var selectedTeam: Team!
    
    var players = [Players]()
    var filterPlayers = [Players]()
    var cellPlayer = ""
    
    var ref:DatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        
        startObservingDatabase()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   /* func startObservingDatabase () {
        //  let currentPlayer = selectedPost["uid"] as? String
        let currentTeam = selectedTeam.teamUid
        
        ref?.child("Team").child(currentTeam!).child("players").observe(.value, with: { (snapshot) in
            var newItems = [Players]()
            
            for itemSnapShot in snapshot.children {
                let item = Players(snapshot: itemSnapShot as! DataSnapshot)

                newItems.append(item)
            }
            
            self.players = newItems
            self.tableView.reloadData()
            
        })
    }
 */
    func startObservingDatabase () {
        //  let currentPlayer = selectedPost["uid"] as? String
        let currentTeam = selectedTeam.teamUid
        
        ref?.child("Team").child(currentTeam!).child("player").observe(.value, with: { (snapshot) in
            var newItems = [Players]()
            
            for itemSnapShot in snapshot.children {
                let item = Players(snapshot: itemSnapShot as! DataSnapshot)
                
                self.cellPlayer = item.uid!
          
                
                newItems.append(item)
            }
            
            self.players = newItems
            self.tableView.reloadData()
            
        })
    }
    
    /*
     ref?.child("Players").observeSingleEvent(of: .value, with: { (snapshot) in
     
     for itemSnapShot in snapshot.children {
     // let item = Players(snapshot: itemSnapShot as! DataSnapshot)
     
     if (itemSnapShot as AnyObject).hasChild(self.cellPlayer)
     {
     
     print("match")
     
     }
     else
     {
     
     print("not match")
     }
     
     
     }
     
     
     }) { (error) in
     
     print(error.localizedDescription)
     }
     */
    
   

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamSquadCell", for: indexPath)
        
        let object = players[indexPath.row]

        ref?.child("Players").observeSingleEvent(of: .value, with: { (snapshot) in
            
        cell.textLabel?.text = object.firstName
            
            if snapshot.hasChild(object.uid)
            {
            
                
                print("match")
                
            }
            else
            {

                print("not matched" )
            }
            
            
        }) { (error) in
            
            print(error.localizedDescription)
        }
        
        
 
        return cell
        // return configureCell(cell, at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "passTeamSquadPlayer"{
            
            
            guard let detailVC = segue.destination as? PlayerProfileViewController, let indexPath = tableView.indexPathForSelectedRow else{ return }
            
            detailVC.selectedPost = players[indexPath.row]
            print(players.count, "ssss")
            
            
            
            
            
        }
    }
    
}
