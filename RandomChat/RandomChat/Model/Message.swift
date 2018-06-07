//
//  Message.swift
//  RandomChat
//
//  Created by Trevor on 7/6/18.
//  Copyright © 2018 toantt. All rights reserved.
//

import UIKit

class Message: NSObject {
    var name: String?
    var sender_id: String?
    var text: String?
    
    init(name: String?, sender_id: String?, text: String?){
        self.name = name
        self.sender_id = sender_id
        self.text = text
    }
}
