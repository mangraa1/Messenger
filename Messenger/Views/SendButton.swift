//
//  SendButtonView.swift
//  Messenger
//
//  Created by mac on 28.11.2023.
//

import SwiftUI

struct SendButton: View {

    // Changes in one view are automatically reflected in the other
    @Binding var text: String

    var body: some View {

        Button {
            self.sendMessage()
        } label: {
            Image(systemName: "paperplane")
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 28))
                .frame(width: 50, height: 50)
                .background(Color.blue)
                .foregroundStyle(Color.white)
                .clipShape(Circle())
        }
    }


    //MARK: - Functions
    func sendMessage() {
        guard !text.isEmpty else { return }
    }
}

//#Preview {
//    SendButton()
//}
