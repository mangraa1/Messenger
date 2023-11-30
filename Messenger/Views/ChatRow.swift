//
//  ChatRowView.swift
//  Messenger
//
//  Created by mac on 28.11.2023.
//

import SwiftUI

struct ChatRow: View {

    let type: MessageType

    var isSender: Bool {
        return type == .sent
    }

    init(type: MessageType) {
        self.type = type
    }

    var body: some View {
        HStack {

            if isSender { Spacer() }

            if !isSender {
                // User icon
                VStack {
                    Spacer() // indentation so that the icon is at the bottom
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundStyle(Color(.systemPink))
                }
            }

            // Message
            HStack {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                    .foregroundStyle(isSender ? Color.white : Color(.label))
                    .padding()

            }
            .background(isSender ? Color.blue : Color(.systemGray4))
            .padding(isSender ? .leading : .trailing,
                     isSender ? UIScreen.main.bounds.width/3 : UIScreen.main.bounds.width/5)
            .clipShape(RoundedRectangle(cornerRadius: 6))

            if !isSender { Spacer() }
        }
    }
}

#Preview {
    Group {
        ChatRow(type: .sent)
        ChatRow(type: .received)
    }
}
