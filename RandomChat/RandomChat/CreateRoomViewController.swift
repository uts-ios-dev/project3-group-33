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

class CreateRoomViewController: UIViewController {
    
    @IBOutlet weak var createRoomBtn: UIButton!
    @IBOutlet weak var roomNameTxt: UITextField!
    
    var ref: DatabaseReference!
    
    let userID = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func createRoom(_ sender: UIButton) {
        guard let roomName = roomNameTxt.text else {print("Please enter a room name"); return}
        
        self.ref = Database.database().reference(fromURL: "https://randomchat-a2052.firebaseio.com/")
        let roomRef = self.ref.child("rooms").childByAutoId()
        
        var users: [String] = []
        users.append(userID)
        
        let value = ["roomName": roomName, "numOfUsers": "1", "users": users] as [String : Any]
        roomRef.updateChildValues(value)
    }
    
}
