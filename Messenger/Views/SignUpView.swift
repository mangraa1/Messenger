//
//  SignUpView.swift
//  Messenger
//
//  Created by mac on 28.11.2023.
//

import SwiftUI

struct SignUpView: View {

    @State var username: String = ""
    @State var password: String = ""
    @State var email: String = ""

    var body: some View {
        NavigationView {
            VStack {
                // Heading
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .padding()

                Text("Sign Up")
                    .bold()
                    .font(.system(size: 23))

                // TextFields
                VStack {
                    TextField("Email", text: $email)
                        .modifier(CustomField())

                    TextField("Username", text: $username)
                        .modifier(CustomField())

                    SecureField("Password", text: $password)
                        .modifier(CustomField())
                }

                // Sign In
                Button(action: {
                    self.signUp()
                }, label: {
                    Text("Create")
                        .foregroundStyle(Color.white)
                        .frame(width: 160, height: 50)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                })

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Create Account")
        .navigationBarTitleDisplayMode(.inline)
    }

    //MARK: - Functions
    func signUp() {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count <= 6 else { return }
    }
}

#Preview {
    SignUpView()
}
