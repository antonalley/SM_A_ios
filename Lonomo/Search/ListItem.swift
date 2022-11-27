//
//  ListItem.swift
//  Lonomo
//
//  Created by Anton Alley on 11/23/22.
//

import SwiftUI

struct ListItem: View {
    var go_home: () -> ()
    var plan: Plan
    @State var isPlanViewActive: Bool = false
    
    var body: some View {
        NavigationLink(destination: PlanView(plan:plan, isPlanViewActive: $isPlanViewActive, go_home: self.go_home), isActive: $isPlanViewActive){
            HStack{
                VStack{
                    Text(plan.name).font(.title2)
                    Text(plan.time.formatDate())
                }
                Text("@\(plan.location.name)")
            }.padding()
                .frame(width: partial_width(percent: 0.9))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.1))
                )
                .cornerRadius(10)
        }
    }
}

//struct ListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        ListItem()
//    }
//}
