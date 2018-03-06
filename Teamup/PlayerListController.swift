//
//  PlayerListController.swift
//  Teamup
//
//  Created by Aziz on 2018-03-04.
//  Copyright © 2018 Azizulla. All rights reserved.
//


import UIKit
import CoreData
import FirebaseDatabase
import FirebaseAuth
import Firebase

class PlayerListController: UITableViewController, UISearchResultsUpdating {
    
    
    let searchController = UISearchController(searchResultsController: nil)
    var players = [NSDictionary?]()
    var filteredUsers = [NSDictionary?]()
    
    var selectedPlayer: Players!
    
    @IBOutlet var tabelView: UITableView!
    
    
    
    var ref:DatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        ref = Database.database().reference()
        startObservingDatabase()
        
        
        
        
        
    }
    
    func startObservingDatabase () {
        
        let userID = Auth.auth().currentUser?.uid
        
        ref?.child("Players").queryOrdered(byChild: "name").observe(.childAdded, with: { (snapshot) in
            
            
            let key = snapshot.key
            let snapshot = snapshot.value as? NSDictionary
            snapshot?.setValue(key, forKey: "uid")
            
            if(key == userID)
            {
                print("Same as logged in user, so don't show!")
            }
            else
            {
                self.players.append(snapshot)
                //insert the rows
                self.tabelView.insertRows(at: [IndexPath(row:self.players.count-1,section:0)], with: UITableViewRowAnimation.automatic)
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //    guard let section = fetchedResultsController.sections?[section] else { return 0 }
        //    return section.numberOfObjects
        if searchController.isActive && searchController.searchBar.text != ""{
            return filteredUsers.count
        }
        // return self.usersArray.count
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playerscell = tableView.dequeueReusableCell(withIdentifier: "PlayersCell", for: indexPath) as? PlayersCell
        
        // let object = players[indexPath.row]
        // playerscell?.friendNameLabel.text = object.firstName
        
        let user : NSDictionary?
        
        if searchController.isActive && searchController.searchBar.text != ""{
            
            user = filteredUsers[indexPath.row]
        }
        else
        {
            user = self.players[indexPath.row]
        }
        playerscell?.playerNameLabel.text = user?["firstName"] as? String
        playerscell?.playerPositionLabel.text = user?["position"] as? String

        
        let currentPlayerUid = user?["uid"] as? String
 
        let imageStorageRef = Storage.storage().reference().child("players").child(currentPlayerUid!).child("profile-400x400.png")
        
        imageStorageRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
            // Error available with .localizedDescription, but can simply be that the image does not exist yet
            if error == nil{
                
                print(data)
                
                playerscell?.profileImage.image = UIImage(data: data!)
               // self.playerImage.image = UIImage(data: data!)
                print("success uploading image from firebase")
            } else {
                
                print(error?.localizedDescription ?? "testing")
            }
            
        }
       
        
        
        
        return playerscell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    // --- search
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContent(searchText: self.searchController.searchBar.text!)
        
    }
    
    func filterContent(searchText:String)
    {
        self.filteredUsers = self.players.filter{ user in
            
            let username = user?["firstName"] as? String
            
            
            return(username?.lowercased().contains(searchText.lowercased()))!
            
        }
        
        tableView.reloadData()
    }
    
    // --- MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PassPlayerInfo"{
            
            
            guard let detailVC = segue.destination as? PlayerProfileViewController, let indexPath = tableView.indexPathForSelectedRow else{ return }
            
            detailVC.selectedPost = players[indexPath.row]
            
            
            
            
            
        }
    }
}


