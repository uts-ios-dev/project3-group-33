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

    var ref: DatabaseReference!
    
    @IBAction func createUser(_ sender: UIButton) {
        Auth.auth().signInAnonymously() { (user, error) in
            if let error = error {
                print("Sign in failed:", error.localizedDescription)
                return
            }
            else {
                self.ref = Database.database().reference(fromURL: "https://randomchat-a2052.firebaseio.com/")
                
                print("Sign in with id:", user!.user.uid)
                let username = self.userNameTxt.text!
                
                let isAnonymous = user!.user.isAnonymous  // true
                
                if self.userNameTxt.text!.count > 0 {
                    self.ref.child("users").child(user!.user.uid).setValue(["name" : username])
                }
                else {
                    self.ref.child("users").child(user!.user.uid).setValue(["name" : "unknown"])
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
}

