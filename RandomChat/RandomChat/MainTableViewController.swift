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
    
    var ref: DatabaseReference! = Database.database().reference(fromURL: "https://randomchat-a2052.firebaseio.com/")
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }
    
    func fetchUsers(){
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
            let value = child.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            let user = User(name: name)
            self.users.append(user)
                print(user.name!)
                
            }
        }, withCancel: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numOfRows = 0
        switch(mySegment.selectedSegmentIndex){
        case 0:
            numOfRows = 1
            break
        case 1:
            numOfRows = 1
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
            myCell.textLabel!.text = "none111"
            break
        case 1:
           myCell.textLabel!.text = "none222"
            break
        case 2:
            let user = users[indexPath.row]
            myCell.textLabel!.text = user.name
            break
        default:
            break
        }
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
