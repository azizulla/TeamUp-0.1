//
//  NewPlayerDetailController.swift
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

class NewPlayerDetailController: UIViewController{
    
    var ref:DatabaseReference?
    let storageRef = Storage.storage().reference()
    //  var imageUploadManager: ImageUploadManager?
    
    // var storageRef = Storage().reference()
    
    let imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var playerFirstNameTextField: UITextField!
    @IBOutlet weak var playerLastNameTextField: UITextField!
    @IBOutlet weak var playerGenderTextField: UITextField!
    @IBOutlet weak var playerPhoneNumberTextField: UITextField!
    
    
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
                                      message: " First Name, Last Name, Email, Jersey Number & Position are required.",
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(cancelAction)
        
        
        //   guard let playerEmail = playerEmailTextField.text, !playerEmail.isEmpty else { return present(alert, animated: true, completion: nil)}
        guard let playerFirstName = playerFirstNameTextField.text, !playerFirstName.isEmpty else { return present(alert, animated: true, completion: nil)}
        guard let playerLastName = playerLastNameTextField.text, !playerLastName.isEmpty else { return present(alert, animated: true, completion: nil)}
        guard let playerGender = playerGenderTextField.text, !playerGender.isEmpty else { return present(alert, animated: true, completion: nil)}
        guard let playerPhoneNumber = playerPhoneNumberTextField.text, !playerPhoneNumber.isEmpty else { return  present(alert, animated: true, completion: nil)}
        //      guard let playerPassword = playerPassword.text, !playerPassword.isEmpty else { return present(alert, animated: true, completion: nil)}
        
        
        
        let player:[String : AnyObject] = ["firstName":playerFirstName as AnyObject,
                                           "lastName":playerLastName as AnyObject,
                                           
                                           "phone":playerPhoneNumber as AnyObject,
                                           "gender":playerGender as AnyObject]
        
        
        
        
        // [START basic_write]
        self.ref?.child("Players").child(userID!).updateChildValues(player)
        // [END basic_write]
        //   self.performSegue(withIdentifier: "signIn", sender: nil)
        
        
        //  dismiss(animated: true, completion: nil)
       // performSegue(withIdentifier: "PlayerDetail", sender: self)
        
        
    }
    
    func alert(_ alertMessage: String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}
