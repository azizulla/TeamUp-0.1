//
//  NewPickUpViewController.swift
//  Teamup
//
//  Created by Aziz on 2018-03-03.
//  Copyright © 2018 Azizulla. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import FirebaseDatabase
import FirebaseAuth

class NewPickUpViewController: UIViewController {
    
    var ref:DatabaseReference?
    var player: Players!
    var selectedPost: NSDictionary!
    var currentEvent = ""
    
    @IBOutlet weak var pickUpName: UITextField!
    @IBOutlet weak var squadSize: UITextField!
    @IBOutlet weak var kitColors: UITextField!
    @IBOutlet weak var eventPrice: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = Database.database().reference()
        
        
        
        //  print("AddTaskController context: \(managedObjectContext.description)")
    }
    
    @IBAction func continueButton(_ sender: Any) {
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        // let key = ref?.childByAutoId().key
        
        
        guard let pickUpName = pickUpName.text, !pickUpName.isEmpty else { return }
        guard let squadSize = squadSize.text, !squadSize.isEmpty else { return }
        guard let kitColors = kitColors.text, !kitColors.isEmpty else { return }
        guard let eventPrice = eventPrice.text, !eventPrice.isEmpty else { return }
        
        let uid = ref?.childByAutoId().key
        
        currentEvent = uid!
        
        let pickup:[String : AnyObject] = ["name":pickUpName as AnyObject,
                                           "squad":squadSize as AnyObject,
                                           "author":userID as AnyObject,
                                           "jerseyColor":kitColors as AnyObject,
                                           "price":eventPrice as AnyObject,
                                           "teamUid":uid as AnyObject]
        
        ref?.child("PickUp").child(uid!).setValue(pickup)

        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PickUpDateAndTime"{
            
            
            guard let detailVC = segue.destination as? NewPickUpDateTimeViewController else{ return }
            
            
            detailVC.currentEvent = currentEvent
            
            
            
        }
        
    }
    

    
    
    
}

