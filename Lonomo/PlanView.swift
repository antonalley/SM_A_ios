//
//  PlanView.swift
//  Lonomo
//
//  Created by Anton Alley on 10/10/22.
//

import SwiftUI


struct PlanView: View {
    var plan: Plan = Plan(
        id: 1,
        name: "Pickup Volleyball",
        location: Location(name:"Glenwood courts", x:0, y:0),
        time: "Th 7pm",
        user_is_going: true
//                who: WhoDetail(
    )
    
    var body: some View {
        ZStack{
            HeaderView()
            
            VStack{
                Spacer().frame(height:100)
                
                Text(plan.name).font(.title).bold()
                Text("When").font(.title2).bold()
                Text(plan.time)
                Text("Who").font(.title2).bold()
//                Text()
                Text("Where").font(.title2).bold()
                Text(plan.location.name)
                
                
                Spacer()
                Text(plan.user_is_going ? "Back Out" : "Opt in")
                    .frame(width:partial_width(percent: 0.95), height:50)
                    .background(plan.user_is_going ? Color.red.opacity(0.5) : Color(UIColor(named:"LonomoOrange") ?? .orange))
                    .cornerRadius(10)
            }.multilineTextAlignment(.leading)
            
            
            
        }
    }
}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView()
    }
}
