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
    
    var selectedPost: NSDictionary!
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
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerEmailLabel.text = selectedPost["email"] as? String
        // playerFirstNameLabel.text = selectedPost["firstName"] as? String
        // playerLastNameLabel.text = selectedPost["lastName"] as? String
        playerPositionLabel.text = selectedPost["position"] as? String
        playerJerseyNumberLabel.text = selectedPost["squad"] as? String
      //  playerFriendsLabel.text = selectedPost["uid"] as? String
        
        let first = selectedPost["firstName"] as? String
        let last = selectedPost["lastName"] as? String
        
        playerFirstNameLabel.text = first! + " " + last!
        
        
        
        self.inviteButton.layer.cornerRadius = 10
        self.inviteButton.clipsToBounds = true
        
        let currentPlayerUid = selectedPost["uid"] as? String
        // let profileUrl = selectedPost["profileImageUrl"] as? String
        
        //let imageStorageRef = Storage.storage().reference().child("players/\(currentPlayerUid)profile-400x400.png")
        
        let imageStorageRef = Storage.storage().reference().child("players").child(currentPlayerUid!).child("profile-400x400.png")
        
        imageStorageRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
            // Error available with .localizedDescription, but can simply be that the image does not exist yet
            if error == nil{
                
                print(data)
                
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

