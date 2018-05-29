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
    
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var LogoutBtn: UIBarButtonItem!
    var users = [User]()
    
    var ref: DatabaseReference! = Database.database().reference(fromURL: "https://randomchat-a2052.firebaseio.com/")
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }
    
    func fetchUsers(){
        ref.child("users").observeSingleEvent(of: .childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let user = User()
                user.setValuesForKeys(dictionary)
                print(user.name!)
            }
        }, withCancel: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        return myCell
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
            ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                            }, withCancel: nil)
        }
    }
}
