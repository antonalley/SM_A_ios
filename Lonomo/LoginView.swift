//
//  ContentView.swift
//  SM_A_ios
//
//  Created by Anton Alley on 9/7/22.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var isLoginPage = true
    @State private var isRegisterPage = false
    @State private var user: User? = nil
    
    var body: some View {
        // TODO check if already logged in
        if isLoggedIn || checkLoggedInStatus() {
            HomeView()
        } else if isRegisterPage{
            RegisterView()
        }
        else {
            login
        }

    }
    var login: some View {
        NavigationView {
            ZStack {
                Color(UIColor(named:"LonomoOrange") ?? .orange).ignoresSafeArea()
                VStack{
                    Image("Lonomo Full Transparent-1")
                        .resizable()
                        .scaledToFit()
                        .frame(width:350, height: 350)
                        .offset(y:75)
                        .padding()
                    
                    
                    Spacer()
                }
                
                VStack {
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                    //                        .textCase(.lowercase)
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
                    .background(Color.white.opacity(0.25))
                    .cornerRadius(10)
                    
                    //                    NavigationLink(destination: Text("You are logged in as @\(username)"), isActive: $isLoggedIn) {
                    //                        EmptyView()
                    //                    }
                    
                }
                VStack{
                    Spacer()
                    //                    NavigationLink(destination: RegisterView()){
                    Button("New Account? Sign Up")
                    {
                        isLoginPage = false
                        isRegisterPage = true
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    //                    }
                }
            }.navigationBarHidden(true)
//                .background(UIColor(named: "LonomoOrange"))
        }
        
    }
    
    func checkLoggedInStatus() -> Bool{
        // TODO
        // Check to see if User and authtoken already stored
        return false
    }
    
    func authenticateUser(username: String, password: String){
        UserDefaults.standard.set("TestUser", forKey: "username")
        UserDefaults.standard.set("testAUTHTOKEN", forKey: "authtoken")
        isLoggedIn = true
        isLoginPage = false
    }
    
    func authenticateUserBack(username: String, password: String){
//        if username == "Anton" && password == "test" {
//            isLoggedIn = true
//            isLoginPage = false
//        }
        
        guard let url = URL(string: "http://10.3.114.18/user/login/") else {
            print("api is down")
            return
        }
        
        let toLogin = LoginRequest(username: username, password: password)
        guard let encoded = try? JSONEncoder().encode(toLogin) else {
                    print("failed to encode")
                    return
                }
                
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = encoded
//        request.addValue("Basic cGF1bG9vcnF1aWxsbzpwYWRtYUAxMTU=", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode(User.self, from: data) {
                    DispatchQueue.main.async {
                        if response.success {
                            self.user = response
                            UserDefaults.standard.set(self.user?.username, forKey: "username")
                            UserDefaults.standard.set(self.user?.authtoken, forKey: "authtoken")
                            isLoggedIn = true
                            isLoginPage = false
                        } else {
                            print("Failed to Login")
                        }
                        
                    }
                    return
                }
            }
            
        }.resume()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDevice("iPhone 11")
    }
}
