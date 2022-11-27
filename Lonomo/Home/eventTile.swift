//
//  eventTitle.swift
//  Lonomo
//
//  Created by Anton Alley on 11/23/22.
//

import SwiftUI

struct EventTitle: View {
    var plan: Plan
    @State var isPlanViewActive: Bool = false
    
    func go_home(){
        // Do nothing, a filler function to satisfy parameter
//        isPlanViewActive = false
    }
    
    var body: some View {
        NavigationLink(destination: PlanView(plan:plan, isPlanViewActive: $isPlanViewActive, go_home: go_home), isActive: $isPlanViewActive){
            VStack{
                Text("\t\(plan.name)  @\(plan.time.formatDate())")
                    .foregroundColor(Color.white)
                    .bold()
                Text(plan.location.name)
                    .foregroundColor(Color.gray)
                    .frame(alignment:.leading)
                
                }.padding()
                    .frame(width: partial_width(percent: 0.95), alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(UIColor(named:"LonomoOrange") ?? .orange))
                        //                                .shadow(color: .black, radius:6, x:4, y:4)
                    )
                    .compositingGroup()
                    .shadow(radius:2, x:0, y:2)
                
        }
    }
}

//struct ListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        ListItem()
//    }
//}
