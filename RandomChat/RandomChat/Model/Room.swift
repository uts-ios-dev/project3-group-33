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
    let roomId: String?
    let roomName: String?
    let users: [User]
    let numOfUsers: Int
    let messages: [Message]
    
    init(roomId: String?, roomName: String?, users: [User], numOfUsers: Int, messages: [Message]) {
        self.roomId = roomId
        self.roomName = roomName
        self.users = users
        self.numOfUsers = numOfUsers
        self.messages = messages
    }
}
