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
        VStack{
            HStack{
                Image(systemName: "magnifyingglass").padding()
                TextField("Search...", text: $searchText)
            }.foregroundColor(Color.gray)
                .frame(width:330, height:50)
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
                        Text("@\(dosumm.location)")
                    }.padding()
                        .frame(width: 300)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black.opacity(0.1))
                        )
                        .cornerRadius(10)
                        
                }.foregroundColor(Color.gray)
            }.padding()
            .frame(width:330)
            .cornerRadius(10)
        }
    }
    
    func get_activities(search: String) -> Array<Dosumm>{
        //TODO Get from backend
        return [
            Dosumm(
                id: 2,
                name: "Pickup Vollyball",
                location: "Glenwood courts",
                time: "Th 7pm",
                who: "any"
            ),
            Dosumm(
                id: 1,
                name: "Movie Night",
                location: "Glenwood apt 114",
                time: "Fri 8pm",
                who: "any"
            ),
            Dosumm(
                id: 3,
                name: "Hike Mt timp",
                location: "AF Canyon trailhead",
                time: "SA 9am",
                who: "any"
            ),
        ]
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
