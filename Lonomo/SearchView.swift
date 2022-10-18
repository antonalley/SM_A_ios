//
//  SearchView.swift
//  SM_A_ios
//
//  Created by Anton Alley on 9/29/22.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @State var isHomeView = false
    
    var body: some View{
        if isHomeView{
            HomeView()
        } else{
            search_view
        }
    }
    var search_view: some View {
        ZStack{
//            HeaderView()
            
            VStack{
                HStack{
                    Image(systemName: "magnifyingglass").padding()
                    TextField("Find something to do...", text: $searchText)
                }.foregroundColor(Color.gray)
                    .frame(width:partial_width(percent: 0.95), height:50)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                    .padding()
                
                VStack{
                    ForEach(self.get_activities(search:searchText)){ dosumm in
                        HStack{
                            VStack{
                                Text(dosumm.name).font(.title2)
                                Text(dosumm.time)
                            }
                            Text("@\(dosumm.location.name)")
                        }.padding()
                            .frame(width: partial_width(percent: 0.9))
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black.opacity(0.1))
                            )
                            .cornerRadius(10)
                        
                    }.foregroundColor(Color.gray)
                }.padding()
                    .frame(width:partial_width(percent: 0.95))
                    .cornerRadius(10)
                
                Spacer()
            }
        }
    }
    
    func get_activities(search: String) -> Array<Plan>{
        //TODO Get from backend
        return [
            Plan(
                id: 1,
                name: "Pickup Vollyball",
                location: Location(name:"Glenwood courts", x:0, y:0),
                time: "Th 7pm",
                user_is_going: true
//                who: WhoDetail(
            ),
            Plan(
                id: 2,
                name: "Hike Mt Timp",
                location: Location(name:"trailhead", x:0, y:0),
                time: "Th 7pm",
                user_is_going: true
//                who: WhoDetail(
            ),
            Plan(
                id: 3,
                name: "Potluck",
                location: Location(name:"My Apartment", x:0, y:0),
                time: "Th 7pm",
                user_is_going: true
//                who: WhoDetail(
            ),
            
            
        ]
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
