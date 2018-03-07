//
//  PickUpProfileViewController.swift
//  Teamup
//
//  Created by Aziz on 2018-03-02.
//  Copyright © 2018 Azizulla. All rights reserved.
//


import UIKit
import CoreData
import FirebaseDatabase
import FirebaseAuth
import Firebase


class PickUpProfileViewController: UIViewController {
    
    var selectedPost: PickUp!
    
    var teamSquad: Team!
    
    var team = [Team]()
    var players = [Players]()
    var pickup = [PickUp]()
    var ref:DatabaseReference?
    
    
    
    // @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var kitcolor: UILabel!
    //  @IBOutlet weak var jerseyColor: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var joinButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = selectedPost.pickUpName//["name"] as? String
        kitcolor.text = selectedPost.kitColor//["jerseyColor"] as? String
        eventTime.text = selectedPost.eventTime//["eventTime"] as? String
        eventDate.text = selectedPost.eventDate//["eventDate"] as? String
        price.text = selectedPost.price//["price"] as? String
        
        
        let userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        let currentPickUp = selectedPost.pickUpUid//["teamUid"] as? String
        
        ref?.child("Players").child(userID!).child("PickUp").observeSingleEvent(of: .value, with: { (snapshot) in
            // databaseRef.child("following").child(self.loggedInUser!.uid).child(self.otherUser?["uid"] as! String).observe(.value, with: { (snapshot) in
            
            if snapshot.hasChild(currentPickUp!)
            {
                self.joinButton.setTitle("Already A member", for: .normal)
                print("You are following the user")
                
            }
            else
            {
                self.joinButton.setTitle("Join", for: .normal)
                print("You are not following the user")
            }
            
            
        }) { (error) in
            
            print(error.localizedDescription)
        }
        
        
        
    }
    
    
    @IBAction func pickupJoin(_ sender: Any) {
        
        self.joinButton.setTitle("Joined!", for: .normal)
        
        let userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        
        let currentPickUpAuthor = selectedPost.author
        
        
        let uid = ref?.childByAutoId().key
        let event:[String : AnyObject] = ["fromUid": userID as AnyObject,
                                         "toUid":selectedPost.author as AnyObject,
                                         "stats": "pending" as AnyObject,
                                         "uid": "key" as AnyObject,
                                         "eventUid": selectedPost.pickUpUid as AnyObject]
        
       // ref?.child("notify").child(key!).setValue(team)
        
        ref?.child("Players").child(currentPickUpAuthor!).child("Notify").child("Recieve").child(uid!).setValue(event)
        ref?.child("Players").child(userID!).child("Notify").child("Send").child(uid!).setValue(event)

        
        
        
  /*      //  --- get pickup detail
        
        ref?.child("PickUp").child(currentPickUp!).observeSingleEvent(of: .value, with: { (snapshot) in
            let item = PickUp(snapshot: snapshot as! DataSnapshot)
            
            let price = item.price
            let key = snapshot.key
            let pickupName = item.pickUpName
            
            print(pickupName)
            
            let playerinfo:[String : AnyObject] = ["name": pickupName as AnyObject,
                                                   "teamUid": key as AnyObject,
                                                   "price": price as AnyObject]
            let post = ["/PickUp/\(String(describing: key))": playerinfo]
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
                                                   "key": userID as AnyObject]
            let post = ["/players/\(String(describing: key))": playerinfo]
            
            self.ref?.child("PickUp").child(currentPickUp!).updateChildValues(post)
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        */
        
    }
    
    @IBAction func close(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    // --- Pass Data
    
    /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     if segue.identifier == "PassPlayerInfo"{
     
     
     guard let detailVC = segue.destination as? ProfileTeamListController  else{ return }
     
     let currenTeam = selectedPost
     
     detailVC.selectedPost = currenTeam!
     //detailVC.selectedPost = players[indexPath.row]
     
     
     }
     
     }
     */
    
}

