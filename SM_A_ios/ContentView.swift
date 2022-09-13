//
//  ContentView.swift
//  SM_A_ios
//
//  Created by Anton Alley on 9/7/22.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var isLoginPage = true
    @State private var isRegisterPage = false
    
    var body: some View {
        if isRegisterPage {
            // go to register
            RegisterView()
        } else {
            login
        }
    }
    var login: some View {
        NavigationView {
            ZStack {
                Color.orange.ignoresSafeArea()
                VStack{
                    Image("tribe-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width:250, height: 250)
    //                    .multilineTextAlignment(.leading)
//                        .padding()
                
                    Spacer()
                }
                
                VStack {
//                    Spacer()
//                    Text("Login")
//                        .font(.largeTitle)
//                        .bold()
//                        .padding()
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
                    
                    Button("Login"){
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(Color.white)
                    .frame(width:300, height:50)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    
                    
                    NavigationLink(destination: Text("You are logged in as @\(username)"), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                    
                }
                VStack{
                    Spacer()
                    Button("New Account? Sign Up"){
                        isLoginPage = false
                        isRegisterPage = true
                    }
                    .padding()
                    .foregroundColor(Color.white)
                }
            }.navigationBarHidden(true)
        }
    }
    
    func authenticateUser(username: String, password: String){
        if username == "Anton" && password == "test" {
            isLoggedIn = true
            isLoginPage = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
