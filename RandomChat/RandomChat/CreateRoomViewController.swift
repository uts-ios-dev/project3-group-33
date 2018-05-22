//
//  CreateRoomViewController.swift
//  RandomChat
//
//  Created by Trevor on 21/5/18.
//  Copyright © 2018 toantt. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

struct Room {
    let name: String
    let users: [String]
    let num: String
}

class CreateRoomViewController: UIViewController {
    
    @IBOutlet weak var roomNameTxt: UITextField!
    @IBOutlet weak var createRoomBtn: UIButton!
    
    var ref: DatabaseReference!
    
    let currentUserID = Auth.auth().currentUser!.uid
    
    @IBAction func createRoom(_ sender: UIButton) {
        self.ref = Database.database().reference(fromURL: "https://randomchat-a2052.firebaseio.com/")
        
        self.ref.child("users").child(currentUserID).observe(DataEventType.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if let userName = value?["name"] as? String {
                print(userName)
                let currentUserName = userName
                
                var users: [String] = []
                users.append(currentUserName)
                let roomName = self.roomNameTxt.text!
                
                if (roomName.count > 0) {
                    //let newRoom = Room(name: roomName, users: users)
                    self.ref.child("rooms").childByAutoId().setValue(["roomName": roomName, "users": users, "numOfUsers" : "1"])
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray
        
        // Do any additional setup after loading the view, typically from a nib.
        //saveUserbtn.addTarget(self, action: #selector(saveUser), for: Touchs)
        //ref = Database.database().reference(fromURL: "https://randomchat-a2052.firebaseio.com/")
        //ref.updateChildValues(["something" : 123]) // example writing data
        
    }
}
