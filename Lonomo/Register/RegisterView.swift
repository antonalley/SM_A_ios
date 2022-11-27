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
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var isRegistered = false
    
    @State private var user: User? = nil
    
    
    var body: some View {
        if isRegistered {
//            AddInterests()
            HomeView()
        } else {
            register
        }
    }
    
    var register: some View {
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
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                    Spacer()
                    Button("Register"){
                        registerUser(username: username, password: password, firstName: firstname, lastName:lastname, email:email)
                    }
                    .foregroundColor(Color.white)
                    .frame(width:300, height:50)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .padding()
                    
//                    NavigationLink(destination: Text("You are registered as @\(username)"), isActive: $isRegistered) {
//                        EmptyView()
//                    }
                    
                }
            }.navigationBarHidden(true)
        }
    }
    
    func registerUser_fake(username:String, password:String, firstName:String, lastName:String, email:String) {
        // TODO delete this function, change name registerUserBack
        UserDefaults.standard.set("testUser", forKey: "username")
        UserDefaults.standard.set("testAUTHTOKEN", forKey: "authtoken")
        isRegistered = true
    }
    
    func registerUser(username:String, password:String, firstName:String, lastName:String, email:String) {
        guard let url = URL(string: "http://45.58.32.232:8000/user/register/") else {
            print("api is down")
            return
        }
        
        let toRegister = RegisterRequest(username: username, password: password, email: email, first_name: firstName, last_name: lastName)
        guard let encoded = try? JSONEncoder().encode(toRegister) else {
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
                            UserDefaults.standard.set(self.user?.personID, forKey: "personID")
                            isRegistered = true
//                            isLoggedIn = true
//                            isLoginPage = false
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
