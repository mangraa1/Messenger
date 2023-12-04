//
//  Message.swift
//  Messenger
//
//  Created by mac on 28.11.2023.
//

import Foundation


enum MessageType {
    case sent
    case received
}

struct Message {
    var text: String
    var type: MessageType
    var Created: String // Data
}
