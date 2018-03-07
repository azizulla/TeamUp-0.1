//
//  MainTeamViewController.swift
//  Teamup
//
//  Created by Aziz on 2018-03-02.
//  Copyright © 2018 Azizulla. All rights reserved.
//


import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth


class MainTeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var selectedTeam: Team!
    
    var team = [Team]()
    var ref:DatabaseReference?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataSearchButton: UIButton!
    @IBOutlet weak var noDataLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        startObservingDatabase()
        
    }
    
    
    func startObservingDatabase () {
        let userID = Auth.auth().currentUser?.uid
        
        ref?.child("Players").child(userID!).child("team").observe(.value, with: { (snapshot) in
            var newItems = [Team]()
            
            for itemSnapShot in snapshot.children {
                let item = Team(snapshot: itemSnapShot as! DataSnapshot)
                newItems.append(item)
            }
            
            self.team = newItems
            self.tableView.reloadData()
            
        })
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        var numberOfSection: Int = 0
        if team.count > 0{
        
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
        return team.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTeam", for: indexPath)
        // var cell = UITableViewCell(style: .default, reuseIdentifier:"cell")
        
        let object = team[indexPath.row]
        cell.textLabel?.text = object.teamName
        
        
        return cell
        // return configureCell(cell, at: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "myTeamProfile"{
            
            let navigationController = segue.destination as! UINavigationController
            let detailVC = navigationController.topViewController as! TeamProfileView
            let indexPath = tableView.indexPathForSelectedRow
            
           // guard let detailVC = segue.destination as? TeamProfileView, let indexPath = tableView.indexPathForSelectedRow else{ return }
            
            detailVC.selectedTeam = team[(indexPath?.row)!]
           // detailVC.selectedTeam = team[indexPath.row]
            
    
           // detailVC.selectedTeam = team[indexPath.row]
            
        }
        
    }

    
    
}
