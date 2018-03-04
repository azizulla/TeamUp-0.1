//
//  NewPickUpDateTimeViewController.swift
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

class NewPickUpDateTimeViewController: UIViewController {
    
    var ref:DatabaseReference?
    var player: Players!
    var selectedPost: NSDictionary!
    var currentEvent = ""
    
    @IBOutlet weak var pickUpDate: UITextField!
    @IBOutlet weak var pickUpTime: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = Database.database().reference()
        
        
        
        //  print("AddTaskController context: \(managedObjectContext.description)")
    }
    
    @IBAction func continueButton(_ sender: Any) {
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        // let key = ref?.childByAutoId().key
        let current  = currentEvent as AnyObject
        
        
        guard let pickupDate = pickUpDate.text, !pickupDate.isEmpty else { return }
        guard let pickupTime = pickUpTime.text, !pickupTime.isEmpty else { return }
        
        
        
        
        let pickup:[String : AnyObject] = ["eventDate":pickupDate as AnyObject,
                                           "eventTime":pickupTime as AnyObject]
        
        ref?.child("PickUp").child(current as! String).updateChildValues(pickup)
        
        print(currentEvent)
      //  performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // ---- date picker
    @IBAction func textFieldEditing(_ sender: UITextField) {
        
        let datePickerView: UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(NewPickUpDateTimeViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
    }
    func datePickerValueChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        pickUpDate.text = dateFormatter.string(from: sender.date)
        
    }
    
    // ---- time picker
    @IBAction func timeFieldEditing(_ sender: UITextField) {
        
        let datePickerView: UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.time
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(NewPickUpDateTimeViewController.timePickerValueChanged), for: UIControlEvents.valueChanged)
        
    }
    
    
    func timePickerValueChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.none
        
        dateFormatter.timeStyle = DateFormatter.Style.medium
        
        pickUpTime.text = dateFormatter.string(from: sender.date)
        
    }
    
    
    
    
}

