//
//  ViewController.swift
//  RandomChat
//
//  Created by Trevor on 12/5/18.
//  Copyright © 2018 toantt. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var saveUserbtn: UIButton!
    
    var ref: DatabaseReference!
    var userUid: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //saveUserbtn.addTarget(self, action: #selector(saveUser), for: Touchs)
        //ref = Database.database().reference(fromURL: "https://randomchat-a2052.firebaseio.com/")
        //ref.updateChildValues(["something" : 123]) // example writing data
    
    }
    
    
    @IBAction func saveUser(_ sender: UIButton) {
        Auth.auth().signInAnonymously() { (user, error) in
            print("Signed in anonymously")
            let uid = user!.user.uid
        }
    }
    
    
}
