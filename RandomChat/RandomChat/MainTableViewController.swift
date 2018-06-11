//
//  MainTableViewController.swift
//  RandomChat
//
//  Created by Lương Linh on 24/5/18.
//  Copyright © 2018 toantt. All rights reserved.
//

import UIKit
import Firebase

class MainTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBAction func segmentChangeIndex(_ sender: UISegmentedControl) {
        myTableView.reloadData()
    }
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var mySegment: UISegmentedControl!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var LogoutBtn: UIBarButtonItem!
    var users = [User]()
    var rooms = [Room]()
    var myRooms = [Room]()
    var myRoomsId = [String]()
    let currentUserId = Auth.auth().currentUser?.uid
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        fetchRooms()
        fetchMyRooms()
    }
    
    func fetchUsers() {
        Constants.refs.databaseUser.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let value = child.value as? NSDictionary
                let name = value?["name"] as? String ?? ""
                
                let user = User(name: name)
                self.users.append(user)
                
                print(user.name!)
            }
        }, withCancel: nil)
    }
    
    func fetchRooms() {
        Constants.refs.databaseRoom.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let value = child.value as? NSDictionary
                let roomId = value?["roomId"] as? String ?? ""
                let roomName = value?["roomName"] as? String ?? ""
                let numOfUsers = Int(value?["numOfUsers"] as? String ?? "0")
                let users = [String]()
                let messages = [Message]()
                
                let room = Room(roomId: roomId, roomName: roomName, users: users, numOfUsers: numOfUsers!, messages: messages)
                self.rooms.append(room)
                
                print(room.roomName!)
                print(room.numOfUsers)
            }
        }, withCancel: nil)
    }
    
    func fetchMyRooms() {
        self.myRoomsId = defaults.array(forKey: "myRoomsId") as! [String]
        
        Constants.refs.databaseRoom.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let value = child.value as? NSDictionary
                let roomId = value?["roomId"] as? String ?? ""
                for r in self.myRoomsId {
                    if (r == roomId) {
                        let roomName = value?["roomName"] as? String ?? ""
                        let numOfUsers = Int(value?["numOfUsers"] as? String ?? "0")
                        let users = [String]()
                        let messages = [Message]()
                        
                        let myRoom = Room(roomId: roomId, roomName: roomName, users: users, numOfUsers: numOfUsers!, messages: messages)
                        self.myRooms.append(myRoom)
                    }
                }
            }
        }, withCancel: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numOfRows = 0
        switch(mySegment.selectedSegmentIndex){
        case 0:
            numOfRows = rooms.count
            break
        case 1:
            numOfRows = myRooms.count
            break
        case 2:
            numOfRows = users.count
            break
        default:
            break
        }
        return numOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        switch(mySegment.selectedSegmentIndex){
        case 0:
            let room = rooms[indexPath.row]
            myCell.textLabel!.text = room.roomName
            myCell.detailTextLabel!.text = "\(room.numOfUsers) user(s)"
            break
        case 1:
            let myRoom = myRooms[indexPath.row]
            myCell.textLabel!.text = myRoom.roomName
            myCell.detailTextLabel!.text = "\(myRoom.numOfUsers) user(s)"
            break
        case 2:
            let user = users[indexPath.row]
            myCell.textLabel!.text = user.name
            myCell.detailTextLabel!.text = ""
            break
        default:
            break
        }
        return myCell
    }
    
    // room selected, get room id and set current room to userdefaults
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (mySegment.selectedSegmentIndex == 0){
        let roomId = self.rooms[indexPath.row].roomId
        defaults.set(roomId, forKey: "roomId")
        
        if (self.myRoomsId.contains(roomId!) == false) {
            self.myRoomsId.append(roomId!)
            defaults.set(myRoomsId, forKey: "myRoomsId")
        }
        
        Constants.refs.databaseRoom.child(roomId!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var roomUsers = value?["users"] as? [String]
            
            if (roomUsers?.contains(self.currentUserId!) == false) {
                roomUsers?.append(self.currentUserId!)
            }
            
            self.rooms[indexPath.row].numOfUsers = (roomUsers?.count)!
            Constants.refs.databaseRoom.child(roomId!).updateChildValues(["numOfUsers" : "\(self.rooms[indexPath.row].numOfUsers)"])
        })}
    }
    
    @IBAction func handleLogout(_ sender: UIBarButtonItem) {
        do {
        try Auth.auth().signOut()
        let viewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        present(viewController!,animated: true, completion: nil )
        } catch {print("Error signing out")}
    }
    
    func checkUserLogedIn(){
        if Auth.auth().currentUser?.uid == nil {
            let viewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
            present(viewController!,animated: true, completion: nil )
        } else {
            let uid = Auth.auth().currentUser!.uid
            Constants.refs.databaseUser.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                            }, withCancel: nil)
        }
    }
}
