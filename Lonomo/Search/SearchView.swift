//
//  SearchView.swift
//  SM_A_ios
//
//  Created by Anton Alley on 9/29/22.
//

import SwiftUI

struct SearchView: View {
    @Binding var isSearchView: Bool
    
    @State var searchText = ""
    @State var plans = [Plan]()
    @State var isPlanViewActive = false
    
//    var body: some View{
//        if isHomeView{
//            HomeView()
//        } else{
//            search_view
//        }
//    }
    var body: some View {
        NavigationView{
            ZStack{
                //            HeaderView()
                
                VStack{
                    HStack{
                        Image(systemName: "magnifyingglass").padding()
                        let binding = Binding<String>(get: {
                            self.searchText
                        }, set: {
                            self.searchText = $0
                            get_activities()
                        })
                        TextField("Find something to do...", text: binding)
                    }.foregroundColor(Color.gray)
                        .frame(width:partial_width(percent: 0.95), height:50)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                        .padding()
                    
                    VStack{
                        ScrollView{
                            
                            ForEach(plans){ plan in
                                ListItem(go_home: self.go_home, plan: plan)
                                
                            }.foregroundColor(Color.gray)
                        }
                    }.padding()
                        .frame(width:partial_width(percent: 0.95))
                        .cornerRadius(10)
                    
                    
                    Spacer()
                }
            }
        }.onAppear(perform:get_activities)
    }
    
    func go_home(){
        isSearchView = false
    }
    
    func get_activities(){
        let authtoken = UserDefaults.standard.string(forKey: "authtoken") ?? ""
        guard let url = URL(string: "http://45.58.32.232:8000/plans/getuserplans/?is_search=true&search_term=\(searchText)") else {
            print("api is down")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Token \(authtoken)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Plan_data].self, from: data) {
                    DispatchQueue.main.async {
                        self.plans = []; // Reset list
                        for plan in response{
                            self.plans.append(plan_from_data(plan_data: plan, interests: Array<InterestForPlan>()));
                        }
                        
                    }
                    return
                }
            }
            
        }.resume()
        return
        
    }
    
//    func get_activities_(){
//        //TODO Get from backend
//        let wd = WhoDetail(interests:[
//            InterestForPlan(id: 1, name: "Volleyball", weight: 10, num_people_included: 10),
//            InterestForPlan(id: 2, name: "Programming", weight: 4, num_people_included: 100),
//            InterestForPlan(id: 3, name: "Surfaces", weight: 5, num_people_included: 4),
//            InterestForPlan(id: 4, name: "Music", weight: 4, num_people_included: 100),
//            InterestForPlan(id: 5, name: "One Republic", weight: 5, num_people_included: 4),
//            InterestForPlan(id: 6, name: "Pickleball", weight: 10, num_people_included: 10),
//            InterestForPlan(id: 7, name: "basketball", weight: 3, num_people_included: 20),
//        ])
//        self.plans = [
//            Plan(
//                id: 1,
//                name: "Pickup Vollyball",
//                location: Location(name:"Glenwood courts", x:0, y:0),
//                time: Date(),
//                who: wd, user_is_going: true
//            ),
//            Plan(
//                id: 2,
//                name: "Hike Mt Timp",
//                location: Location(name:"trailhead", x:0, y:0),
//                time: Date(),
//                who: wd, user_is_going: true
//            ),
//            Plan(
//                id: 3,
//                name: "Potluck",
//                location: Location(name:"My Apartment", x:0, y:0),
//                time: Date(),
//                who: wd, user_is_going: true
//            ),
//
//
//        ]
//    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
