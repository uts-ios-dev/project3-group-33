//
//  Constant.swift
//  RandomChat
//
//  Created by Trevor on 7/6/18.
//  Copyright © 2018 toantt. All rights reserved.
//

import Firebase

struct Constants {
    struct refs {
        static let databaseRoot = Database.database().reference(fromURL: "https://randomchat-a2052.firebaseio.com/")
        static let databaseUser = databaseRoot.child("users")
        static let databaseRoom = databaseRoot.child("rooms")
    }
}
