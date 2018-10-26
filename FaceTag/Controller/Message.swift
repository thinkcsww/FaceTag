//
//  Message.swift
//  FaceTag
//
//  Created by SunWoong Choi on 22/10/2018.
//  Copyright © 2018 SunWoong Choi. All rights reserved.
//

import Foundation

class Message {
    var userId: String
    var content: String
    var messageId: String
    
    init(userId: String, content: String) {
        self.userId = userId
        self.content = content
        self.messageId = "empty"
    }
    
    
}
