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
    var conversationsListener: ListenerRegistration?
    var chatListener: ListenerRegistration?

    init() {
        // Checking whether there is currently an active session
        self.showingSignIn = Auth.auth().currentUser == nil
    }
}

// Search
extension AppStateModel {
    func searchUsers(queryText: String, completion: @escaping ([String]) -> Void) {

        database.collection("users").getDocuments { snapshot, error in
            guard let usernames = snapshot?.documents.compactMap({ $0.documentID }), error == nil else {
                completion([])
                return
            }

            // Found name
            let filtred = usernames.filter({
                $0.lowercased().hasPrefix(queryText.lowercased())
            })
            completion(filtred)
        }
    }
}

// Conversations
extension AppStateModel {
    func getConversations() {
        // Listen for Conversations

        conversationsListener =  database
            .collection("users")
            .document(currentUsername)
            .collection("chats").addSnapshotListener {[weak self] snapshot, error in

                guard let usernames = snapshot?.documents.compactMap({ $0.documentID }), error == nil else {
                    return
                }

                DispatchQueue.main.async {
                    self?.conversations = usernames
                }
            }
    }
}

// Get Chat / Send messages
extension AppStateModel {
    func observeChat() {
        createConversations()

        chatListener = database
            .collection("users")
            .document()
            .collection("chats")
            .document(otherUsername)
            .collection("messanges").addSnapshotListener {[weak self] snapshot, error in

                // Get messages as an array of objects
                guard let objects = snapshot?.documents.compactMap({ $0.data() }), error == nil else {
                    return
                }

                // Parsing objects from the database into an array of messages
                let messanges = objects.compactMap({
                    return Message(
                        text: $0["text"] as? String ?? "",
                        type: $0["sender"] as? String == self?.currentUsername ? .sent : .received,
                        created: DateFormatter().date(from: $0["created"] as? String ?? "") ?? Date()
                    )
                })

                DispatchQueue.main.async {
                    self?.messages = messanges
                }
            }
    }

    func sendMessage(text: String) {

    }

    func createConversations() {

        // Adding an interlocutor to the general list of chats for the current user
        database.collection("users")
            .document(currentUsername)
            .collection("chats")
            .document(otherUsername).setData(["created": "true"])

        // Creating a chat for the user with whom you started the dialogue
        database.collection("users")
            .document(otherUsername)
            .collection("chats")
            .document(currentUsername).setData(["created": "true"])
    }
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
