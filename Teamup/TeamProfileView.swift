//
//  TeamProfileView.swift
//  Teamup
//
//  Created by Aziz on 2018-03-02.
//  Copyright © 2018 Azizulla. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import FirebaseDatabase
import FirebaseAuth



class TeamProfileView: UIViewController {
    
    var selectedTeam: Team!
    var team = [Team]()
    var ref:DatabaseReference?
    var otherUser:NSDictionary?
    
    var refreshcontrol = UIRefreshControl()
    
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue){}
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamSquadsize: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamName.text = selectedTeam.teamName
        teamSquadsize.text = selectedTeam.teamUid
        ref = Database.database().reference()
        
        
        
        let userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        let currenTeam = selectedTeam.teamUid
        
        ref?.child("Players").child(userID!).child("team").observeSingleEvent(of: .value, with: { (snapshot) in
            // databaseRef.child("following").child(self.loggedInUser!.uid).child(self.otherUser?["uid"] as! String).observe(.value, with: { (snapshot) in
            
            if snapshot.hasChild(currenTeam!)
            {
                self.joinButton.setTitle("Unfollow", for: .normal)
                print("You are following the user")
                
            }
            else
            {
                self.joinButton.setTitle("Follow", for: .normal)
                print("You are not following the user")
            }
            
            
        }) { (error) in
            
            print(error.localizedDescription)
        }
        
        
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //  --- join Button
    
    @IBAction func joinTeam(_ sender: Any) {
        
        
        self.joinButton.setTitle("Joined!", for: .normal)
        
        let userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        let currenTeam = selectedTeam.teamUid
        
        
        
        
        //  --- get team detail
        
        ref?.child("Team").child(currenTeam!).observeSingleEvent(of: .value, with: { (snapshot) in
            let item = Team(snapshot: snapshot as! DataSnapshot)
            
            let teamName = item.teamName
            let key = snapshot.key
            
            let playerinfo:[String : AnyObject] = ["name": teamName as AnyObject,
                                                   "teamUid": key as AnyObject]
            let post = ["/team/\(String(describing: key))": playerinfo]
            self.ref?.child("Players").child(userID!).updateChildValues(post)
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //  --- get player detail
        
        ref?.child("Players").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            //let value = snapshot.value as? NSDictionary
            let item = Players(snapshot: snapshot as! DataSnapshot)
            let firstName = item.firstName
            
            let key = snapshot.key
            
            let playerinfo:[String : AnyObject] = ["firstName": firstName as AnyObject,
                                                   "uid": userID as AnyObject]
            let post = ["/players/\(String(describing: key))": playerinfo]
            
            self.ref?.child("Team").child(currenTeam!).updateChildValues(post)
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
    } // end of join button
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PassTeamSquadInfo"{
            
            let navigationController = segue.destination as! UINavigationController
            let addTaskController = navigationController.topViewController as! TeamSquadListViewController
            
            //guard let detailVC = segue.destination as? TeamSquadListViewController  else{ return }
            // let addTaskController = navigationController.topViewController as! AddTaskController
            
            
            let currenTeam = selectedTeam
            addTaskController.selectedTeam = currenTeam
            
            
            
        }
        
    }
    
    
    
}

