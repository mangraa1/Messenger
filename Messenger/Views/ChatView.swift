//
//  ChatView.swift
//  Messenger
//
//  Created by mac on 28.11.2023.
//

import SwiftUI

struct ChatView: View {

    // When the value changes, redraws the view
    @State var message: String = ""

    var body: some View {
        VStack {
            // Chat messages
            ScrollView(.vertical) {
                ChatRow(type: .sent)
                    .padding(3)
                ChatRow(type: .received)
                    .padding(3)
            }

            // Message field
            HStack {
                TextField("Message...", text: $message)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 7))

                SendButton(text: $message)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width, height: 57)
        }
        .navigationTitle("Samantha")
    }
}

#Preview {
    ChatView()
}
