//
//  RegisterView.swift
//  SM_A_ios
//
//  Created by Anton Alley on 9/12/22.
//

import SwiftUI

struct RegisterView: View{
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var username = ""
    @State private var password = ""
    @State private var isRegistered = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.orange.ignoresSafeArea()
                
                VStack {
                    Text("Register")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("First Name", text: $firstname)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                    TextField("Last Name", text: $lastname)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                    Spacer()
                    Button("Register"){
//                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(Color.white)
                    .frame(width:300, height:50)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .padding()
                    
                    NavigationLink(destination: Text("You are registered as @\(username)"), isActive: $isRegistered) {
                        EmptyView()
                    }
                    
                }
            }.navigationBarHidden(true)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
