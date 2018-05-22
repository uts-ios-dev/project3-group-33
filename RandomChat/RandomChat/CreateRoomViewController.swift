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
    let users: [User]
    let num = 0
    
}

class CreateRoomViewController: UIViewController {
    
    @IBOutlet weak var roomNameTxt: UITextField!
    @IBOutlet weak var createRoomBtn: UIButton!
    var ref: DatabaseReference!
    let currentUser = Auth.auth().currentUser!
    let userID = Auth.auth().currentUser!.uid
    
    @IBAction func createRoom(_ sender: UIButton) {
        let users: [User] = [currentUser]
        let name = roomNameTxt.text!
        if (name.count > 0) {
            let newRoom = Room(name: name, users: users)
            self.ref = Database.database().reference(fromURL: "https://randomchat-a2052.firebaseio.com/")
            let roomRef = self.ref.child("rooms").childByAutoId()
            let value = ["room": newRoom]
            roomRef.updateChildValues(value)
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
