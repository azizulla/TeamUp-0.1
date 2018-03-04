//
//  NewPlayerSportDetailController.swift
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

class NewPlayerSportDetailController: UIViewController{
    
    var ref:DatabaseReference?
    let storageRef = Storage.storage().reference()
    //  var imageUploadManager: ImageUploadManager?
    
    // var storageRef = Storage().reference()
    
    let imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var position: UITextField!
    @IBOutlet weak var jerseyNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        //     profileImage.image = UIImage(named: "867366")
    }
    
    
    // ---  saving the player
    
    @IBAction func playerDetail(_ sender: Any) {
        
        let userID = Auth.auth().currentUser?.uid
        
        ref = Database.database().reference().root
        
        let alert = UIAlertController(title: "Ugh...",
                                      message: "Position and Jersey Number required!",
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(cancelAction)
        
        // let profileImage = self.profileImage
        
        
        //   guard let playerEmail = playerEmailTextField.text, !playerEmail.isEmpty else { return present(alert, animated: true, completion: nil)}
        guard let position = position.text, !position.isEmpty else { return present(alert, animated: true, completion: nil)}
        guard let jerseyNumber = jerseyNumber.text, !jerseyNumber.isEmpty else { return present(alert, animated: true, completion: nil)}
        
        
        
        
        
        
        
        let player:[String : AnyObject] = ["position":position as AnyObject,
                                           "kitNumber":jerseyNumber as AnyObject]
        
        
        
        
        // [START basic_write]
        self.ref?.child("Players").child(userID!).updateChildValues(player)
        // [END basic_write]
        //   self.performSegue(withIdentifier: "signIn", sender: nil)
        
        
        //  dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "location", sender: self)
        
        
    }
    
    func alert(_ alertMessage: String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}

