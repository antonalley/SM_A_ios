//
//  HomeView.swift
//  SM_A_ios
//
//  Created by Anton Alley on 9/17/22.
//

import SwiftUI
import WrappingHStack

extension AnyTransition {
    static var moveFadeDown: AnyTransition {
        // TODO , not working great
        .asymmetric(
            insertion: AnyTransition.move(edge: .bottom),
            removal: AnyTransition.move(edge: .top)
        )
        
    }
}

func partial_width(percent: Float) -> CGFloat{
    return UIScreen.main.bounds.width * CGFloat(percent)
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
                    Spacer().frame(height:100)
                    ScrollView{
                        NavigationLink(destination:CreatePlanView()){
                            Text("\tMake Plans").foregroundColor(Color.white)
                                .frame(width:partial_width(percent: 0.95), height:70, alignment: .leading)
                                .background(Color(UIColor(named:"ButtonBlue") ?? .blue))
                                .cornerRadius(10)
                                .padding()
                                .shadow(radius:2, x:0, y:2)
                        }
                        
                        
                        ForEach(get_calendar()){ dosumm in
                            NavigationLink(destination: PlanView(plan:dosumm)){                           VStack{
                                Text("\t\(dosumm.name)  @\(dosumm.time)")
                                    .foregroundColor(Color.white)
                                    .bold()
                                Text(dosumm.location.name)
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
                    
                    
                    Spacer()
                    
//                    NavigationLink(destination: SearchView()) {
                    HStack{
                            Image(systemName: "magnifyingglass").padding()
                            Text("Find something to do...")
                            Spacer()
                        }.foregroundColor(Color.gray)
                        .frame(width:partial_width(percent: 0.95), height:50)
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
    
    func get_calendar() -> Array<Plan>{
        //TODO Get from backend
        return [
            Plan(
                id: 1,
                name: "Pickup Volleyball",
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
