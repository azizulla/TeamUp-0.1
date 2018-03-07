//
//  SearchPickUpViewController.swift
//  Teamup
//
//  Created by Aziz on 2018-03-02.
//  Copyright © 2018 Azizulla. All rights reserved.
//

import UIKit
import CoreData
import FirebaseDatabase
import FirebaseAuth

class SearchPickUpViewController: UITableViewController, UISearchResultsUpdating {
    
    
    var searchController = UISearchController(searchResultsController: nil)
    
    var players = [PickUp]()
    var filteredUsers = [PickUp]()
    
    @IBOutlet var pickUPTabelView: UITableView!
    
    
    
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
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    

    func startObservingDatabase () {
        
        //     let userID = Auth.auth().currentUser?.uid
        
        ref?.child("PickUp").queryOrdered(byChild: "name").observe(.childAdded, with: { (snapshot) in
            
            
            let key = snapshot.key
           // let snapshot = snapshot.value as? NSDictionary
            let item = PickUp(snapshot: snapshot as! DataSnapshot)
            
            self.players.append(item)
            
            print(snapshot, "testing snapshot")
            //insert the rows
            self.pickUPTabelView.insertRows(at: [IndexPath(row:self.players.count-1,section:0)], with: UITableViewRowAnimation.automatic)
            
            
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
        let playerscell = tableView.dequeueReusableCell(withIdentifier: "PickUpCell", for: indexPath) as? PickUpCell
        
        
        
        let user : PickUp
        
        
        if searchController.isActive && searchController.searchBar.text != ""{
            
            user = filteredUsers[indexPath.row]
        }
        else
        {
            user = self.players[indexPath.row]
        }
        
        let name = user.pickUpName//["name"] as! String
        
        
        
        playerscell?.pickUpName.text = name
        
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
            
            let username = user.pickUpName
            
            return(username?.lowercased().contains(searchText.lowercased()))!
            
        }
        
        tableView.reloadData()
    }
    
    
    // --- passing data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PassingPickUpInfo"{
            
            
           // guard let detailVC = segue.destination as? PickUpProfileViewController, let indexPath = tableView.indexPathForSelectedRow else{ return }
            
            //detailVC.selectedPost = players[indexPath.row]
            
            let navigationController = segue.destination as! UINavigationController
            let detailVC = navigationController.topViewController as! PickUpProfileViewController
            let indexPath = tableView.indexPathForSelectedRow
            
            // guard let detailVC = segue.destination as? TeamProfileView, let indexPath = tableView.indexPathForSelectedRow else{ return }
            
            detailVC.selectedPost = players[(indexPath?.row)!]
            // detailVC.selectedTeam = team[indexPath.row]
            

            
            
            
            
        }
    }
    
}


