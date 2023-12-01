//
//  ContentView.swift
//  Messenger
//
//  Created by mac on 27.11.2023.
//

import SwiftUI

struct ConversationListView: View {

    let usernames = ["John", "Tailer", "Jack"]

    var body: some View {

        NavigationView {
            ScrollView(.vertical) {
                ForEach(usernames, id: \.self) { name in
                    NavigationLink(destination: ChatView(otherUsername: name)) {
                        // User chats
                        HStack {
                            Circle()
                                .frame(width: 45, height: 45)
                                .foregroundStyle(Color(.systemPink))

                            Text(name)
                                .bold()
                                .foregroundStyle(Color(.label))
                                .font(.system(size: 23))

                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Conversations")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                // Sign Out
                ToolbarItem(placement: .topBarLeading) {
                    Button("Sign Out") {
                        self.signOut()
                    }
                }

                // Search users
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SearchView()) {
                        Image(systemName: "magnifyingglass")
                    }
                }
            })
        }
    }


    //MARK: - Functions
    func signOut() {
        
    }
}

#Preview {
    ConversationListView()
}
