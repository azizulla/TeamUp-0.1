//
//  PlayerProfileViewController.swift
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


class PlayerProfileViewController: UIViewController {
    
    var selectedPost: Players!
    var teamSquad: Team!
    
    var team = [Team]()
    var players = [Players]()
    var ref:DatabaseReference?
    
    
    
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerEmailLabel: UILabel!
    @IBOutlet weak var playerFirstNameLabel: UILabel!
    @IBOutlet weak var playerLastNameLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var playerJerseyNumberLabel: UILabel!
    @IBOutlet weak var playerFriendsLabel: UILabel!
    
    @IBOutlet weak var inviteButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        
        ref?.child("Players").child(selectedPost.uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            // databaseRef.child("following").child(self.loggedInUser!.uid).child(self.otherUser?["uid"] as! String).observe(.value, with: { (snapshot) in
            
            // if snapshot.hasChild(userID!)
            // {
            
            var newItems = [Players]()
            
            
            let item = Players(snapshot: snapshot as! DataSnapshot)
            newItems.append(item)
            
            
            self.playerEmailLabel.text = item.email
            self.playerPositionLabel.text = item.position
            
            let kitnumber = item.kitNumber
            
            print(kitnumber as Any )
            self.playerJerseyNumberLabel.text = kitnumber
            
            
            let first = item.firstName
            let last = item.lastName
            self.playerFirstNameLabel.text = first! + " " + last!
            
            
        }) { (error) in
            
            print(error.localizedDescription)
        }
        
        
        
        
        // --- getting Images
        let imageStorageRef = Storage.storage().reference().child("players").child(userID!).child("profile-400x400.png")
        
        imageStorageRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
            // Error available with .localizedDescription, but can simply be that the image does not exist yet
            if error == nil{
                
                self.playerImage.image = UIImage(data: data!)
                print("success uploading image from firebase")
            } else {
                
                print(error?.localizedDescription ?? "testing")
            }
        }
    }
    
    
    @IBAction func teamInvite(_ sender: Any) {
        
    }
    
    
    
    
    // --- Pass Data
    
    
    
}

