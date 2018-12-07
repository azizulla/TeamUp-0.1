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
    var positionInfo = "aziz"
    
    
    @IBOutlet weak var position: UITextField!
    @IBOutlet weak var jerseyNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        //     profileImage.image = UIImage(named: "867366")
    }
    
    @IBOutlet weak var nextDetail: UIButton!
    @IBOutlet weak var playerPosition: UISegmentedControl!
    
    @IBAction func playerPositionSegment(_ sender: Any) {
        
        switch playerPosition.selectedSegmentIndex {
        case 0:
            print("GK")
            positionInfo = "GoalKeeper"
            
        case 1:
            print("D")
             positionInfo = "Defender"
        case 2:
            print("M")
             positionInfo = "MedFielder"
        case 3:
            print("ST")
             positionInfo = "Stricker"
        default:
            print("couldnt controle segment")
        }
        
      
        
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
        

        guard !positionInfo.isEmpty else { return present(alert, animated: true, completion: nil)}
        
    
            present(alert, animated: true, completion: nil)
            nextDetail.isHidden = true
            
        
            guard let jerseyNumber = jerseyNumber.text, !jerseyNumber.isEmpty else { return present(alert, animated: true, completion: nil)}
        
            let player:[String : AnyObject] = ["position":positionInfo as AnyObject,
                                           "kitNumber":jerseyNumber as AnyObject]
        
            self.ref?.child("Players").child(userID!).updateChildValues(player)
       
        
        
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

