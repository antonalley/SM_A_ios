//
//  HomeView.swift
//  SM_A_ios
//
//  Created by Anton Alley on 9/17/22.
//

import SwiftUI

extension AnyTransition {
    static var moveFadeDown: AnyTransition {
        // TODO , not working great
        .asymmetric(
            insertion: AnyTransition.move(edge: .bottom),
            removal: AnyTransition.move(edge: .top)
        )
        
    }
}

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isHomeView = true
    @State private var isDoSomethingView = false
    @State private var isSearchView = false
    @State var searchText = ""
    
    
    var body: some View{
        home_view
    }
    
    var home_view: some View {
        NavigationView{
            ZStack{
                HeaderView()
                VStack{
                    Spacer()
                    NavigationLink(destination:CreatePlanView()){
                    Text("Do something...                            +").foregroundColor(Color.white)
                            .frame(width:330, height:50)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding()
                    }
                    
                    
                    VStack{
                        Text("Your Plans")
                            .foregroundColor(Color.white)
                            .font(.title)
                        ScrollView{
                            ForEach(get_calendar()){ dosumm in
                                HStack{
                                    VStack{
                                        Text(dosumm.name).font(.title2).foregroundColor(Color.white)
                                        Text(dosumm.time)
                                    }
                                    Text("@\(dosumm.location)")
                                }.padding()
                                    .frame(width: 300)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white.opacity(0.2))
                                        //                                .shadow(color: .black, radius:6, x:4, y:4)
                                    )
                                    .cornerRadius(10)
                                
                            }.foregroundColor(Color.white)
                        }.frame(height:300)
                    }.padding()
                        .background(Color.orange)
                        .frame(width:330)
                        .cornerRadius(10)
                    
                    Spacer()
                    
//                    NavigationLink(destination: SearchView()) {
                    HStack{
                            Image(systemName: "magnifyingglass").padding()
                            Text("Find something to do...")
                            Spacer()
                        }.foregroundColor(Color.gray)
                            .frame(width:330, height:50)
                            .background(colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1))
                            .cornerRadius(10)
                            .padding()
                            .onTapGesture(){
                                isSearchView = true
                            }
//                    }
                    
                    
                }
            }
        }.sheet(isPresented: $isSearchView){
            SearchView()
//                .presentationDetents([.medium, .large])
        }
    }
    
    func get_calendar() -> Array<Dosumm>{
        //TODO Get from backend
        return [
            Dosumm(
                id: 1,
                name: "Pickup Vollyball",
                location: "Glenwood courts",
                time: "Th 7pm",
                who: "any"
            ),
            Dosumm(
                id: 2,
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
            Dosumm(
                id: 4,
                name: "Pickup Vollyball",
                location: "Glenwood courts",
                time: "Th 7pm",
                who: "any"
            ),
            Dosumm(
                id: 5,
                name: "Movie Night",
                location: "Glenwood apt 114",
                time: "Fri 8pm",
                who: "any"
            ),
            Dosumm(
                id: 6,
                name: "Hike Mt timp",
                location: "AF Canyon trailhead",
                time: "SA 9am",
                who: "any"
            ),
        ]
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
