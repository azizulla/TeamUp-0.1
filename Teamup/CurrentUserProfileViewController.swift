//
//  CurrentUserProfileViewController.swift
//  Teamup
//
//  Created by Aziz on 2018-03-03.
//  Copyright © 2018 Azizulla. All rights reserved.
//


import UIKit
import CoreData
import FirebaseDatabase
import FirebaseAuth
import Firebase


class CurrentUserProfileViewController: UIViewController {
    
    var selectedPost: NSDictionary!
    var playerInfo: Players!
    
    var team = [Team]()
    
    var ref:DatabaseReference?
    
    
    

    @IBOutlet weak var playerEmailLabel: UILabel!
    @IBOutlet weak var playerFirstNameLabel: UILabel!
    // @IBOutlet weak var playerLastNameLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var kitNumberLabel: UILabel!
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        
        ref?.child("Players").observeSingleEvent(of: .value, with: { (snapshot) in
            // databaseRef.child("following").child(self.loggedInUser!.uid).child(self.otherUser?["uid"] as! String).observe(.value, with: { (snapshot) in
            
            if snapshot.hasChild(userID!)
            {
                var newItems = [Players]()
                
                for itemSnapShot in snapshot.children {
                    let item = Players(snapshot: itemSnapShot as! DataSnapshot)
                    newItems.append(item)
                    
                    
                    self.playerEmailLabel.text = item.email
                    self.playerPositionLabel.text = item.position
                    
                    let kitnumber = item.kitNumber
                    
                    print(kitnumber as Any )
                    self.kitNumberLabel.text = kitnumber
                    
                    
                    let first = item.firstName
                    let last = item.lastName
                    self.playerFirstNameLabel.text = first! + " " + last!
                    
                    
                }
                
            }
            else
            {
                
                print("failed player detail")
            }
            
            
        }) { (error) in
            
            print(error.localizedDescription)
        }
        
        
        
        
        // --- getting Images
        let imageStorageRef = Storage.storage().reference().child("players").child(userID!).child("profile-400x400.png")
        
        imageStorageRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
            // Error available with .localizedDescription, but can simply be that the image does not exist yet
            if error == nil{
                
                self.profileImageView.image = UIImage(data: data!)
                print("success uploading image from firebase")
            } else {
                
                print(error?.localizedDescription ?? "testing")
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
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
    
    
    
    
    // --- getting data
    
    
    
}

