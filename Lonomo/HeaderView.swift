//
//  HeaderView.swift
//  SM_A_ios
//
//  Created by Anton Alley on 10/3/22.
//

import SwiftUI

struct HeaderView: View {
    @State var goToLoginView = false
    
    var body: some View {
        if goToLoginView {
            LoginView()
        } else {
            main_body
        }
    }
    
    var main_body: some View {
        VStack(){
            ZStack{
                HStack{
                    //                Color.orange.ignoresSafeArea()
                    Image("Lonomo header-1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                    
                    
                    
                }.frame(height:65)
                // TODO get shadow at the top
                //                .background(RoundedRectangle(cornerRadius: 0)
                //                    .fill(Color.white)
                //                )
                //                .compositingGroup()
                //                .shadow(radius:4,x:0,y:1)
                HStack{
                    Spacer()
                    Image(systemName: "person.crop.circle")
                        .imageScale(.large)
                        .foregroundColor(Color(UIColor(named: "LonomoOrange") ?? .orange))
                        .onTapGesture(){
                            // LOGOUT
                            logout()
                            // TODO change to go to profile page
                            
                        }
                        .padding()
                }
                
            }
            
            Spacer()
        }
    }
    
    func logout(){
        UserDefaults.standard.set("", forKey: "username")
        UserDefaults.standard.set("", forKey: "authtoken")
        UserDefaults.standard.set("", forKey: "personID")
//        goToLoginView = true
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
