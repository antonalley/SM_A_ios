//
//  DoSomethingView.swift
//  SM_A_ios
//
//  Created by Anton Alley on 9/29/22.
//

import SwiftUI

struct CreatePlanView: View {
    @State var what = ""
    @State var when = ""
    @State var where_ = ""
    @State var who = ""
    @State var isdosomethingview = true
    var body: some View {
        if isdosomethingview{
            createplanView
        } else {
            HomeView()
        }
    }
    var createplanView: some View {
        ZStack{
//            HeaderView()
            VStack{
                Text("Create Plan")
                    .font(.title)
                TextField("What?", text:$what)
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                TextField("When?", text:$when)
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                TextField("Where?", text:$where_)
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                TextField("Who?", text:$who)
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                Button("Send Plan"){
                    // Create dosumm with info
                    var new_event = Dosumm(id: Int.random(in: 100...10000),name:self.what, location:self.where_, time:self.when, who:self.who)
                    isdosomethingview = false
                }.foregroundColor(Color.white)
                    .frame(width:300, height:50)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .padding()
                
                
            }
        }
        
    }
}

struct CreeatePlanView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlanView()
    }
}
