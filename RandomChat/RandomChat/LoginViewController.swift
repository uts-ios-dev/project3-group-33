//
//  ViewController.swift
//  RandomChat
//
//  Created by Trevor on 12/5/18.
//  Copyright © 2018 toantt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var createUser: UIButton!
    
    var defaults = UserDefaults.standard
    let roomId = String()
    let myRoomsId = [String]()
    
    @IBAction func createUser(_ sender: UIButton) {
        defaults.set(roomId, forKey: "roomId")
        defaults.set(myRoomsId, forKey: "myRoomsId")
        
        Auth.auth().signInAnonymously() { (user, error) in
            if let error = error {
                print("Sign in failed:", error.localizedDescription)
                return
            }
            else {
                print("Sign in with id:", user!.user.uid)
                let username = self.userNameTxt.text!
                
                _ = user!.user.isAnonymous  // true
                
                if self.userNameTxt.text!.count > 0 {
                    Constants.refs.databaseUser.child(user!.user.uid).setValue(["name" : username])
                }
                else {
                    Constants.refs.databaseUser.child(user!.user.uid).setValue(["name" : "unknown"])
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
}

