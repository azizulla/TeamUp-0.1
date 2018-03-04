//
//  NewTeamViewController.swift
//  Teamup
//
//  Created by Aziz on 2018-03-02.
//  Copyright © 2018 Azizulla. All rights reserved.
//


import UIKit
import CoreData
import FirebaseDatabase
import FirebaseAuth

class NewTeamViewController: UIViewController {
    
    var ref:DatabaseReference?
    var player: Players!
    var managedObjectContext: NSManagedObjectContext!
    
    
    
    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var teamNumberOfPlayersTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = Database.database().reference()
        
        
        
        //  print("AddTaskController context: \(managedObjectContext.description)")
    }
    
    @IBAction func save(_ sender: Any) {
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        //  let author = Auth.auth().currentUser?.email
        let key = ref?.childByAutoId().key
        
        
        guard let teamName = teamNameTextField.text, !teamName.isEmpty else { return }
        guard let teamPlayers = teamNumberOfPlayersTextField.text, !teamPlayers.isEmpty else { return }
        
        
        
        
        
        
        let player:[String : AnyObject] = ["players": userID as AnyObject]
        
        let team:[String : AnyObject] = ["name":teamName as AnyObject,
                                         "squad":teamPlayers as AnyObject,
                                         "player":player as AnyObject,
                                         "author": userID as AnyObject,
                                         "teamUid": key as AnyObject]
        
        ref?.child("Team").child(key!).setValue(team)
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

