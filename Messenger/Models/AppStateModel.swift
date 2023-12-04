//
//  AppStateModel.swift
//  Messenger
//
//  Created by mac on 28.11.2023.
//

import Foundation
import SwiftUI


class AppStateModel: ObservableObject {
    @AppStorage("currentUsername") var currentUsername: String = ""
    @AppStorage("currentEmail") var currentEmail: String = ""

    // Is user signed in
    @Published var showingSignIn: Bool = true
    @Published var conversations: [String] = []
    @Published var messages: [Message] = []

    var otherUsername: String = ""

    // Current user being chatted with
    // Messages, Conversations
}

// Search
extension AppStateModel {
    func searchUsers(queryText: String, completion: @escaping ([String]) -> Void) {

    }
}

// Conversations
extension AppStateModel {
    func observeChat() {

    }

    func sendMessage(text: String) {

    }

    func createConversationsIfNeeded() {

    }
}

// Get Chat / Send messages
extension AppStateModel {

}

// Sign In & Sign Up
extension AppStateModel {
    func signIn(username: String, password: String) {
        // Try to sign in
    }

    func signUp(email: String, username: String, password: String) {
        // Sign up
    }

    func signOut() {
        // Sign out
    }
}
