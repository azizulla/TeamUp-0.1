//
//  WelcomeController.swift
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

class WelcomeController: UIViewController{
    
    var ref:DatabaseReference?
    let storageRef = Storage.storage().reference()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        //     profileImage.image = UIImage(named: "867366")
    }
    
    
    // ---  saving the player
    
    @IBAction func playerDetail(_ sender: Any) {
        //   dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "toMain", sender: self)
        
        
    }
    
}

