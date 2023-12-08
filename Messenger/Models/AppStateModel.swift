//
//  AppStateModel.swift
//  Messenger
//
//  Created by mac on 28.11.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AppStateModel: ObservableObject {
    @AppStorage("currentUsername") var currentUsername: String = ""
    @AppStorage("currentEmail") var currentEmail: String = ""

    // Is user signed in
    @Published var showingSignIn: Bool = true
    @Published var conversations: [String] = []
    @Published var messages: [Message] = []

    let database = Firestore.firestore()
    let auth = Auth.auth()

    var otherUsername: String = ""

    init() {
        // Checking whether there is currently an active session
        self.showingSignIn = Auth.auth().currentUser == nil
    }
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
        // Get email from DB
        database.collection("users").document(username).getDocument {[weak self] snapshot, error in
            guard let email = snapshot?.data()?["email"] as? String, error == nil else { return }

            // Try to sign in
            self?.auth.signIn(withEmail: email, password: password, completion: { result, error in
                guard result != nil, error == nil else { return }

                DispatchQueue.main.async {
                    self?.currentEmail = email
                    self?.currentUsername = username
                    self?.showingSignIn = false
                }
            })
        }
    }

    func signUp(email: String, username: String, password: String) {
        // Create account
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else { return }

            // Insert username into database
            let data = [
                "email": email,
                "password": password]

            self?.database
                .collection("users")
                .document(username)
                .setData(data, completion: { error in
                    guard error == nil else { return }
                    
                    DispatchQueue.main.async {
                        self?.currentUsername = username
                        self?.currentEmail = email
                        self?.showingSignIn = false
                    }
                })
        }
    }

    func signOut() {
        do {
            try auth.signOut()
            self.showingSignIn = true
        } catch let error {
            print("Error: ", error.localizedDescription)
        }
    }
}
