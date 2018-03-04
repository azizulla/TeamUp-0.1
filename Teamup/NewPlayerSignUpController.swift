//
//  NewPlayerSignUpController.swift
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



class NewPlayerSignUpControllerr: UIViewController{
    
    var ref:DatabaseReference?
    let storageRef = Storage.storage().reference()
    //  var imageUploadManager: ImageUploadManager?
    
    // var storageRef = Storage().reference()
    
    
    @IBOutlet weak var playerEmailTextField: UITextField!
    
    @IBOutlet weak var playerPassword: UITextField!
    @IBOutlet weak var playerRetypePassword: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        //     profileImage.image = UIImage(named: "867366")
    }
    
    
    
    // ---  saving the player
    
    @IBAction func signUp(_ sender: Any) {
        
        
        ref = Database.database().reference().root
        
        let alert = UIAlertController(title: "Ugh...",
                                      message: " Email and password requrired!",
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(cancelAction)
        
        // let profileImage = self.profileImage
        
        
        guard let playerEmail = playerEmailTextField.text, !playerEmail.isEmpty else { return present(alert, animated: true, completion: nil)}
        
        guard let playerPassword = playerPassword.text, !playerPassword.isEmpty else { return present(alert, animated: true, completion: nil)}
        
        
        
        
        // Create the user with the provided credentials
        Auth.auth().createUser(withEmail: playerEmail, password: playerPassword, completion: { (user, error) in
            
            guard let user = user, error == nil else {
                //  self.showMessagePrompt(error!.localizedDescription)
                return
            }
            
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = playerEmail
            
            let userID = user.uid
            
            
            let player:[String : AnyObject] = ["email":playerEmail as AnyObject,
                                               "uid":userID as AnyObject]
            
            // Commit profile changes to server
            changeRequest?.commitChanges() { (error) in
                
                
                // [START basic_write]
                self.ref?.child("Players").child(user.uid).setValue(player)
                // [END basic_write]
                Auth.auth().signIn(withEmail: self.playerEmailTextField.text!,password: self.playerPassword.text!)
                //   self.performSegue(withIdentifier: "signIn", sender: nil)
            }
            
            
        })
        
        
        
        
        //  dismiss(animated: true, completion: nil)
        
        performSegue(withIdentifier: "SignUp", sender: self)
        
    }
    
    func alert(_ alertMessage: String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
}


