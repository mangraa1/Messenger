//
//  ChatRowView.swift
//  Messenger
//
//  Created by mac on 28.11.2023.
//

import SwiftUI

struct ChatRow: View {
    @EnvironmentObject var model: AppStateModel

    let type: MessageType
    let text: String

    var isSender: Bool {
        return type == .sent
    }

    init(text: String, type: MessageType) {
        self.text = text
        self.type = type
    }

    var body: some View {
        HStack {

            if isSender { Spacer() }

            if !isSender {
                // User icon
                VStack {
                    Spacer() // indentation so that the icon is at the bottom
                    Image(model.currentUsername == "Heorhii" ? "manPhoto": "girlPhoto")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                        .foregroundStyle(Color(.systemPink))
                        .clipShape(Circle())
                }
            }

            // Message
            HStack {
                Text(text)
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

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChatRow(text: "Sent test", type: .sent)
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            ChatRow(text: "Received test", type: .received)
                .preferredColorScheme(.light)
        }
        .previewLayout(.sizeThatFits)
    }
}
