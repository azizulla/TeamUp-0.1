//
//  ViewController.swift
//  Teamup
//
//  Created by Aziz on 2018-03-02.
//  Copyright © 2018 Azizulla. All rights reserved.
//
/*

 //
 //  TeamProfileView.swift
 //  Teamup
 //
 //  Created by Aziz on 2018-03-02.
 //  Copyright © 2018 Azizulla. All rights reserved.
 //
 
 import Foundation
 import UIKit
 import CoreData
 import FirebaseDatabase
 import FirebaseAuth
 
 
 
 class TeamProfileView: UIViewController, UITableViewDelegate, UITableViewDataSource  {
 
 var selectedTeam: Team!
 var team = [Team]()
 var ref:DatabaseReference?
 var otherUser:NSDictionary?
 var players = [Players]()
 
 var refreshcontrol = UIRefreshControl()
 
 
 @IBAction func unwindSegue(_ sender: UIStoryboardSegue){}
 @IBOutlet weak var teamName: UILabel!
 @IBOutlet weak var teamSquadsize: UILabel!
 @IBOutlet weak var joinButton: UIButton!
 @IBOutlet weak var tableView: UITableView!
 
 
 override func viewDidLoad() {
 super.viewDidLoad()
 teamName.text = selectedTeam.teamName
 teamSquadsize.text = selectedTeam.teamUid
 ref = Database.database().reference()
 
 
 startObservingDatabase()
 
 let userID = Auth.auth().currentUser?.uid
 ref = Database.database().reference()
 let currenTeam = selectedTeam.teamUid
 
 ref?.child("Players").child(userID!).child("Team").observeSingleEvent(of: .value, with: { (snapshot) in
 // databaseRef.child("following").child(self.loggedInUser!.uid).child(self.otherUser?["uid"] as! String).observe(.value, with: { (snapshot) in
 
 if snapshot.hasChild(currenTeam!)
 {
 self.joinButton.setTitle("Unfollow", for: .normal)
 print("You are already a memeber of this team")
 
 
 self.ref?.child("Team").observe(.value, with: { (snapshot) in
 for itemSnapShot in snapshot.children {
 let item = Team(snapshot: itemSnapShot as! DataSnapshot)
 
 if currenTeam == item.teamUid{
 self.teamName.text = item.teamName
 self.teamSquadsize.text = item.squad
 
 } else {print("error team")}
 }
 
 //   self.team = newItems
 
 
 })
 }
 else
 {
 self.joinButton.setTitle("Follow", for: .normal)
 print("You are not member of this team")
 }
 
 
 }) { (error) in
 
 print(error.localizedDescription)
 }
 
 
 }
 
 func startObservingDatabase () {
 //  let currentPlayer = selectedPost["uid"] as? String
 let currentTeam = selectedTeam.teamUid
 
 ref?.child("Players").observe(.value, with: { (snapshot) in
 var newItems = [Players]()
 
 for itemSnapShot in snapshot.children {
 let item = Players(snapshot: itemSnapShot as! DataSnapshot)
 print("player found", item.uid!)
 newItems.append(item)
 }
 
 self.players = newItems
 self.tableView.reloadData()
 
 })
 }
 
 func numberOfSections(in tableView: UITableView) -> Int {
 // #warning Incomplete implementation, return the number of sections
 return 1
 }
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 // #warning Incomplete implementation, return the number of rows
 return players.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
 let cell = tableView.dequeueReusableCell(withIdentifier: "SquadCell", for: indexPath)
 
 let object = players[indexPath.row]
 
 cell.textLabel?.text = object.firstName
 
 print(object.uid)
 /*  ref?.child("Players").observeSingleEvent(of: .value, with: { (snapshot) in
 
 if snapshot.hasChild(object.uid)
 {
 for itemSnapShot in snapshot.children {
 let item = Players(snapshot: itemSnapShot as! DataSnapshot)
 
 if object.uid == item.uid{
 cell.textLabel?.text = ""item.uid""
 print(item.firstName)
 
 } else {print("error team")}
 }
 
 }
 else { print("not matched" )}
 
 
 }) { (error) in
 
 print(error.localizedDescription)
 }
 */
 
 
 return cell
 // return configureCell(cell, at: indexPath)
 }
 
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 return 80
 }
 @IBAction func cancel(_ sender: Any) {
 dismiss(animated: true, completion: nil)
 }
 
 //  --- join Button
 
 @IBAction func joinTeam(_ sender: Any) {
 
 
 self.joinButton.setTitle("Joined!", for: .normal)
 
 let userID = Auth.auth().currentUser?.uid
 ref = Database.database().reference()
 let currenTeam = selectedTeam.teamUid
 
 let currentPickUpAuthor = selectedTeam.author
 
 
 let uid = ref?.childByAutoId().key
 let event:[String : AnyObject] = ["fromUid": userID as AnyObject,
 "toUid":selectedTeam.author as AnyObject,
 "stats": "pending" as AnyObject,
 
 "eventUid": selectedTeam.teamUid as AnyObject]
 
 // ref?.child("notify").child(key!).setValue(team)
 
 ref?.child("Players").child(currentPickUpAuthor!).child("Notify").child("Recieve").child(selectedTeam.teamUid!).setValue(event)
 ref?.child("Players").child(userID!).child("Notify").child("Send").child(selectedTeam.teamUid!).setValue(event)
 
 
 } // end of join button
 
 
 
 
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
 if segue.identifier == "PassTeamSquadInfo"{
 
 let navigationController = segue.destination as! UINavigationController
 let addTaskController = navigationController.topViewController as! TeamSquadListViewController
 
 //guard let detailVC = segue.destination as? TeamSquadListViewController  else{ return }
 // let addTaskController = navigationController.topViewController as! AddTaskController
 
 
 let currenTeam = selectedTeam
 addTaskController.selectedTeam = currenTeam
 
 
 
 }
 
 }
 
 //
 
 }
 
 //
 //  TeamProfileView.swift
 //  Teamup
 //
 //  Created by Aziz on 2018-03-02.
 //  Copyright © 2018 Azizulla. All rights reserved.
 //
 
 import Foundation
 import UIKit
 import CoreData
 import FirebaseDatabase
 import FirebaseAuth
 
 
 
 class TeamProfileView: UIViewController, UITableViewDelegate, UITableViewDataSource  {
 
 var selectedTeam: Team!
 var team = [Team]()
 var ref:DatabaseReference?
 var otherUser:NSDictionary?
 var players = [Players]()
 
 var refreshcontrol = UIRefreshControl()
 
 
 @IBAction func unwindSegue(_ sender: UIStoryboardSegue){}
 @IBOutlet weak var teamName: UILabel!
 @IBOutlet weak var teamSquadsize: UILabel!
 @IBOutlet weak var joinButton: UIButton!
 @IBOutlet weak var tableView: UITableView!
 
 
 override func viewDidLoad() {
 super.viewDidLoad()
 teamName.text = selectedTeam.teamName
 teamSquadsize.text = selectedTeam.teamUid
 ref = Database.database().reference()
 
 
 startObservingDatabase()
 
 let userID = Auth.auth().currentUser?.uid
 ref = Database.database().reference()
 let currenTeam = selectedTeam.teamUid
 
 ref?.child("Players").child(userID!).child("Team").observeSingleEvent(of: .value, with: { (snapshot) in
 // databaseRef.child("following").child(self.loggedInUser!.uid).child(self.otherUser?["uid"] as! String).observe(.value, with: { (snapshot) in
 
 if snapshot.hasChild(currenTeam!)
 {
 self.joinButton.setTitle("Unfollow", for: .normal)
 print("You are already a memeber of this team")
 
 
 self.ref?.child("Team").observe(.value, with: { (snapshot) in
 for itemSnapShot in snapshot.children {
 let item = Team(snapshot: itemSnapShot as! DataSnapshot)
 
 if currenTeam == item.teamUid{
 self.teamName.text = item.teamName
 self.teamSquadsize.text = item.squad
 
 } else {print("error team")}
 }
 
 //   self.team = newItems
 
 
 })
 }
 else
 {
 self.joinButton.setTitle("Follow", for: .normal)
 print("You are not member of this team")
 }
 
 
 }) { (error) in
 
 print(error.localizedDescription)
 }
 
 
 }
 
 func startObservingDatabase () {
 //  let currentPlayer = selectedPost["uid"] as? String
 let currentTeam = selectedTeam.teamUid
 
 ref?.child("Players").observe(.value, with: { (snapshot) in
 var newItems = [Players]()
 
 for itemSnapShot in snapshot.children {
 let item = Players(snapshot: itemSnapShot as! DataSnapshot)
 print("player found", item.uid!)
 newItems.append(item)
 }
 
 self.players = newItems
 self.tableView.reloadData()
 
 })
 }
 
 func numberOfSections(in tableView: UITableView) -> Int {
 // #warning Incomplete implementation, return the number of sections
 return 1
 }
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 // #warning Incomplete implementation, return the number of rows
 return players.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
 let cell = tableView.dequeueReusableCell(withIdentifier: "SquadCell", for: indexPath)
 
 let object = players[indexPath.row]
 
 cell.textLabel?.text = object.firstName
 
 print(object.uid)
 /*  ref?.child("Players").observeSingleEvent(of: .value, with: { (snapshot) in
 
 if snapshot.hasChild(object.uid)
 {
 for itemSnapShot in snapshot.children {
 let item = Players(snapshot: itemSnapShot as! DataSnapshot)
 
 if object.uid == item.uid{
 cell.textLabel?.text = ""item.uid""
 print(item.firstName)
 
 } else {print("error team")}
 }
 
 }
 else { print("not matched" )}
 
 
 }) { (error) in
 
 print(error.localizedDescription)
 }
 */
 
 
 return cell
 // return configureCell(cell, at: indexPath)
 }
 
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 return 80
 }
 @IBAction func cancel(_ sender: Any) {
 dismiss(animated: true, completion: nil)
 }
 
 //  --- join Button
 
 @IBAction func joinTeam(_ sender: Any) {
 
 
 self.joinButton.setTitle("Joined!", for: .normal)
 
 let userID = Auth.auth().currentUser?.uid
 ref = Database.database().reference()
 let currenTeam = selectedTeam.teamUid
 
 let currentPickUpAuthor = selectedTeam.author
 
 
 let uid = ref?.childByAutoId().key
 let event:[String : AnyObject] = ["fromUid": userID as AnyObject,
 "toUid":selectedTeam.author as AnyObject,
 "stats": "pending" as AnyObject,
 
 "eventUid": selectedTeam.teamUid as AnyObject]
 
 // ref?.child("notify").child(key!).setValue(team)
 
 ref?.child("Players").child(currentPickUpAuthor!).child("Notify").child("Recieve").child(selectedTeam.teamUid!).setValue(event)
 ref?.child("Players").child(userID!).child("Notify").child("Send").child(selectedTeam.teamUid!).setValue(event)
 
 
 } // end of join button
 
 
 
 
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
 if segue.identifier == "PassTeamSquadInfo"{
 
 let navigationController = segue.destination as! UINavigationController
 let addTaskController = navigationController.topViewController as! TeamSquadListViewController
 
 //guard let detailVC = segue.destination as? TeamSquadListViewController  else{ return }
 // let addTaskController = navigationController.topViewController as! AddTaskController
 
 
 let currenTeam = selectedTeam
 addTaskController.selectedTeam = currenTeam
 
 
 
 }
 
 }
 
 //
 
 }
 

*/
