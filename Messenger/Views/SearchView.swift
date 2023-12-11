//
//  SearchView.swift
//  Messenger
//
//  Created by mac on 28.11.2023.
//

import SwiftUI


struct SearchView: View {

    @EnvironmentObject var model: AppStateModel
    @Environment(\.dismiss) var dissmiss

    @State private var selectedName: String?
    @State var text: String = ""
    @State var usernames: [String] = []

    let completion: (String) -> Void // We pass the name of the user we found

    init(completion: @escaping (String) -> Void) {
        self.completion = completion
    }

    var body: some View {
        VStack {
            TextField("Username...", text: $text)
                .modifier(CustomField())
                .autocorrectionDisabled()
                .autocapitalization(.none)

            Button("Search") {
                guard !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }

                model.searchUsers(queryText: text) { usernames in
                    self.usernames = usernames
                }
            }
            .padding()

            List {
                ForEach(usernames, id: \.self) { name in
                    // Users
                    HStack {
                        Circle()
                            .frame(width: selectedName == name ? 55 : 45, height: selectedName == name ? 55 : 45)
                            .foregroundStyle(selectedName == name ? Color(.systemBlue) : Color(.systemPink))
                            .rotationEffect(.degrees(selectedName == name ? 45 : 0))
                            .scaleEffect(selectedName == name ? 1.1 : 1.0)

                        Text(name)
                            .bold()
                            .font(.system(size: 24))
                            .foregroundColor(selectedName == name ? Color(.systemBlue) : Color(.label))

                        Spacer()
                    }
                    .onTapGesture {

                        // Animate row
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedName = name
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.easeInOut) {
                                selectedName = nil
                            }
                        }

                        // Record the found user
                        completion(name)

                        // Closes the current screen
                        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.4) {
                            dissmiss()
                        }
                    }
                }
            }
        }
        .navigationTitle("Search")
    }
}

#Preview {
    SearchView() { _ in}
}
