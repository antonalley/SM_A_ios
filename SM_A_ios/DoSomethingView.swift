//
//  DoSomethingView.swift
//  SM_A_ios
//
//  Created by Anton Alley on 9/29/22.
//

import SwiftUI

struct DoSomethingView: View {
    @State var what = ""
    @State var when = ""
    @State var where_ = ""
    @State var who = ""
    @State var isdosomethingview = true
    var body: some View {
        if isdosomethingview{
            dosumView
        } else {
            HomeView()
        }
    }
    var dosumView: some View {
        VStack{
            Text("Do something")
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
            Button("Create dosum'm"){
                // Create dosumm with info
                var new_event = Dosumm(id: Int.random(in: 100...10000),name:self.what, location:self.where_, time:self.when, who:self.who)
                isdosomethingview = false
            }.foregroundColor(Color.white)
                .frame(width:300, height:50)
                .background(Color.orange.opacity(0.8))
                .cornerRadius(10)
                .padding()
            
            
        }
        
    }
}

struct DoSomethingView_Previews: PreviewProvider {
    static var previews: some View {
        DoSomethingView()
    }
}
