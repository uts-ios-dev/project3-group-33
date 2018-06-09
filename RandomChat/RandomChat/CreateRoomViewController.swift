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
    
    let defaults = UserDefaults.standard
    
    let userID = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func createRoom(_ sender: UIButton) {
        guard let roomName = roomNameTxt.text else {print("Please enter a room name"); return}
        
        let roomRef = Constants.refs.databaseRoom.childByAutoId()
        
        let roomId = roomRef.key
        
        defaults.set(roomId, forKey: "roomId")
        
        let messages: [Message] = []
        
        var users: [String] = []
        users.append(userID)
        
        let room = ["roomId": roomId, "roomName": roomName, "numOfUsers": "1", "users": users, "messages": messages] as [String : Any]
        roomRef.updateChildValues(room)
    }
}
