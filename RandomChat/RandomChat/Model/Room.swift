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
    let messages: [Message]
    
    init(roomName: String?, users: [String], numOfUsers: Int, messages: [Message]){
        self.roomName = roomName
        self.users = users
        self.numOfUsers = numOfUsers
        self.messages = messages
    }
}
