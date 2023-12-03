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

                // TestFields
                VStack {
                    TextField("Username", text: $username)
                        .modifier(CustomField())

                    SecureField("Password", text: $password)
                        .modifier(CustomField())
                }

                // Sign In
                Button(action: {
                    model.signIn(username: username, password: password)
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
}

#Preview {
    SignInView()
}
