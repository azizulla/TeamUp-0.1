//
//  NewPlayerImageProfileController.swift
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

class NewPlayerImageProfileController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ref:DatabaseReference?
    let storageRef = Storage.storage().reference()
    //  var imageUploadManager: ImageUploadManager?
    
    // var storageRef = Storage().reference()
    
    let imagePicker = UIImagePickerController()
    
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var imageUploadProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        //     profileImage.image = UIImage(named: "867366")
    }
    
    @IBAction func uploadImageButton(_ sender: Any) {
        
        let imagePickerButton = UIImagePickerController()
        imagePickerButton.allowsEditing = false
        imagePickerButton.sourceType = .photoLibrary
        imagePickerButton.delegate = self
        
        present(imagePickerButton, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImage.image = image
        profileImage.contentMode = .scaleAspectFill
        
        
        let userID = Auth.auth().currentUser?.uid
        
        let imageData = UIImagePNGRepresentation(self.profileImage.image!)
        
        //let storageRef = Storage.storage().reference().child("players/\(userID)/profile-400x400.png")
        
        let storageRef = Storage.storage().reference().child("players").child(userID!).child("profile-400x400.png")
        
        let metadata = StorageMetadata(dictionary: ["contentType": "image/png"])
        
        
        storageRef.putData(imageData!, metadata: metadata) { (metadata, error) in
            guard metadata != nil else {
                print("Error uploading image to Firebase Storage: \(error?.localizedDescription)")
                return
            }
            
            //let storageRef = Storage.storage().reference().child("shared/profile-80x80.png")
            //storageRef.putData(imageData!, metadata: StorageMetadata(dictionary: ["contentType": "image/png"]))
            
            print("Uploda complete! \(metadata?.downloadURL())")
            let imageurl = metadata?.downloadURL()?.absoluteString
            //   self.ref?.child("Players").child(userID!).child("profileImageUrl").setValue(imageurl)
            
            
        }
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
