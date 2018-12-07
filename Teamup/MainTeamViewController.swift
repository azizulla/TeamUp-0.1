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
        
        ref?.child("Players").child(userID!).child("Team").observe(.value, with: { (snapshot) in
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
       
        let object = team[indexPath.row]
        cell.textLabel?.text = object.teamUid
        
        ref?.child("Team").observe(.value, with: { (snapshot) in
          //  var newItems = [Team]()
            
            for itemSnapShot in snapshot.children {
                let item = Team(snapshot: itemSnapShot as! DataSnapshot)

               if object.teamUid == item.teamUid{
                    cell.textLabel?.text = item.teamName

                } else {print("error team3")}
            }
            
         //   self.team = newItems

        })

        return cell

    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Message") { (action, indexpath) in
            //YOUR_CODE_HERE
            print("message", indexpath.row)
        }
        deleteAction.backgroundColor = .red
        return [deleteAction]
    }
    
  /*  @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accpet = UIContextualAction(style: .normal, title: "Accept") { (action, view, nil) in
            print("accpet")
        }
        return UISwipeActionsConfiguration(actions: [accpet])
    }*/
    
  /*  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
 
    */
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
