//
//  ChatView.swift
//  Messenger
//
//  Created by mac on 28.11.2023.
//

import SwiftUI

// Specific template to create TextField
struct CustomField: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 7))
    }
}

struct ChatView: View {

    // When the value changes, redraws the view
    @State var message: String = ""
    let otherUsername: String

    init(otherUsername: String) {
        self.otherUsername = otherUsername
    }

    var body: some View {
        VStack {
            // Chat messages
            ScrollView(.vertical) {
                ChatRow(text: "Hello, World", type: .sent)
                    .padding(3)
                ChatRow(text: "Hello",type: .received)
                    .padding(3)
            }

            // Message field
            HStack {
                TextField("Message...", text: $message)
                    .modifier(CustomField())

                SendButton(text: $message)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width, height: 57)
        }
        .navigationTitle(otherUsername)
    }
}

#Preview {
    ChatView(otherUsername: "")
}
