//
//  ContentView.swift
//  Messenger
//
//  Created by mac on 27.11.2023.
//

import SwiftUI

struct ConversationListView: View {

    @EnvironmentObject var model: AppStateModel

    @State var otherUsername: String = ""
    @State var showChat = false

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

                // Enter a chat with the found user
                if !otherUsername.isEmpty {
                    NavigationLink("", destination: ChatView(otherUsername: otherUsername), isActive: $showChat)
                }
            }
            .navigationTitle("Conversations")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Sign Out
                ToolbarItem(placement: .topBarLeading) {
                    Button("Sign Out") {
                        self.signOut()
                    }
                }

                // Search users
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SearchView { name in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.otherUsername = name
                            self.showChat = true
                        }
                    },
                    label: {
                        Image(systemName: "magnifyingglass")
                    })
                }
            }
            .fullScreenCover(isPresented: $model.showingSignIn) {
                SignInView()
            }
        }
    }

    //MARK: - Functions
    func signOut() {
        model.signOut()
    }
}

#Preview {
    ConversationListView()
}
