//
//  SignInView.swift
//  Messenger
//
//  Created by mac on 28.11.2023.
//

import SwiftUI

struct SignInView: View {

    @EnvironmentObject var model: AppStateModel

    @State var username: String = ""
    @State var password: String = ""

    var body: some View {
        NavigationView {
            VStack {
                // Heading
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                Text("Messenger")
                    .bold()
                    .font(.system(size: 34))

                // TextFields
                VStack {
                    TextField("Username", text: $username)
                        .modifier(CustomField())

                    SecureField("Password", text: $password)
                        .modifier(CustomField())
                }

                // Sign In
                Button(action: {
                    self.signIn()
                }, label: {
                    Text("Sign In")
                        .foregroundStyle(Color.white)
                        .frame(width: 160, height: 50)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                })

                Spacer()

                // Sign Up
                HStack {
                    Text("New to Messenger?")
                    NavigationLink("Create Account", destination: SignUpView())
                }
            }
            .padding()
        }
    }

    //MARK: - Functions
    func signIn() {
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count <= 6 else { return }

        model.signIn(username: username, password: password)
    }
}

#Preview {
    SignInView()
}
