//
//  AppStateModel.swift
//  Messenger
//
//  Created by mac on 28.11.2023.
//

import Foundation


class AppStateModel: ObservableObject {
    // Is user signed in
    @Published var showingSignIn: Bool = true

    // Current user being chatted with
    // Messages, Conversations
}

// Search
extension AppStateModel {

}

// Conversations
extension AppStateModel {

}

// Get Chat / Send messages
extension AppStateModel {

}

// Sign In & Sign Up
extension AppStateModel {
    func signIn(username: String, password: String) {
        // Try to sign in
    }
}
