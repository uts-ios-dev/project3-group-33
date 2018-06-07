//
//  Room.swift
//  RandomChat
//
//  Created by Trevor on 4/6/18.
//  Copyright © 2018 toantt. All rights reserved.
//

import Foundation
import UIKit

class Room: NSObject {
    let roomName: String?
    let users: [String]
    let numOfUsers: Int
    
    init(roomName: String?, users: [String], numOfUsers: Int){
        self.roomName = roomName
        self.users = users
        self.numOfUsers = numOfUsers
    }
}
