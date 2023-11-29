//
//  ChatView.swift
//  Messenger
//
//  Created by mac on 28.11.2023.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        ScrollView(.vertical) {
            ChatRow(type: .sent)
                .padding(3)
            ChatRow(type: .received)
                .padding(3)
        }
    }
}

#Preview {
    ChatView()
}
