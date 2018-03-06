//
//  ShowTeamTeamViewController.swift
//  Teamup
//
//  Created by Aziz on 2018-03-02.
//  Copyright © 2018 Azizulla. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth


class ShowTeamViewController: UITableViewController  {
    
    var team = [Team]()
    var ref:DatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        startObservingDatabase()
        
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func signoutButtonPressed(_ sender: AnyObject) {
        /* do {
         try Auth.auth().signOut()
         dismiss(animated: true, completion: nil)
         } catch {
         
         }*/
        if Auth.auth().currentUser != nil{
            
            do {
                try? Auth.auth().signOut()
                
                if Auth.auth().currentUser == nil{
                    
                    let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
                    self.present(loginVC, animated: true, completion: nil)
                }
                
                
            } catch let error as NSError {
                
                print(error.localizedDescription)
            }
            
            
        }
    }
    
    func startObservingDatabase () {
        ref?.child("Team").observe(.value, with: { (snapshot) in
            var newItems = [Team]()
            
            for itemSnapShot in snapshot.children {
                let item = Team(snapshot: itemSnapShot as! DataSnapshot)
                newItems.append(item)
            }
            
            self.team = newItems
            self.tableView.reloadData()
            
        })
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return team.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath)
        // var cell = UITableViewCell(style: .default, reuseIdentifier:"cell")
        
        let object = team[indexPath.row]
        cell.textLabel?.text = object.teamName
        
        
        
        return cell
        // return configureCell(cell, at: indexPath)
    }
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "newTeam" {
            let navigationController = segue.destination as! UINavigationController
            //let addTaskController = navigationController.topViewController as! AddTaskController
            
            
            //addTaskController.managedObjectContext = self.managedObjectContext
            
        }
            
        else if segue.identifier == "showTeam"{
            
            let navigationController = segue.destination as! UINavigationController
            let detailVC = navigationController.topViewController as! TeamProfileView
            let indexPath = tableView.indexPathForSelectedRow
          //  guard let detailVC = segue.destination as? TeamProfileView, let indexPath = tableView.indexPathForSelectedRow else{ return }
            
            // detailVC.selectedTeam = team[indexPath.row]
            detailVC.selectedTeam = team[(indexPath?.row)!]
            
        }
        
    }
    
}
