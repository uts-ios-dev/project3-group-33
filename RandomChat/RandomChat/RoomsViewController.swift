//
//  RoomsViewController.swift
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

/*func getRooms() -> [Room] {
    
    var rooms: [Room] = []
    
    
    return rooms
}*/

class RoomsViewController: UIViewController /*UITableViewDataSource, UITableViewDelegate*/ {
    
   /* @IBOutlet weak var roomsTableView: UITableView!
    
    var ref: DatabaseReference!
    var refHandle: UInt!
    var rooms = [Room]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "room", for: indexPath)
        
        let room = rooms[indexPath.row]
        
        cell.textLabel?.text = room.name
        cell.detailTextLabel?.text = "\(room.num)"
        
        return cell
    }
    
    func fetchRooms() {
        refHandle = ref.child("rooms").observe(.childAdded, with: { (snapshot) in
            let results = snapshot.value as? [String : AnyObject]
                
            let roomName = results?["roomName"]
            let users = results?["users"]
            let numOfUsers = results?["numOfUsers"]
            let room = Room(name: roomName as! String, users: users as! [String], num: numOfUsers as! String)
            self.rooms.append(room)
            DispatchQueue.main.async {
                self.roomsTableView.reloadData()
            }            
        })
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.gray
        
        // Do any additional setup after loading the view, typically from a nib.
        //saveUserbtn.addTarget(self, action: #selector(saveUser), for: Touchs)
        //ref = Database.database().reference(fromURL: "https://randomchat-a2052.firebaseio.com/")
        //fetchRooms()
        
    }
}
