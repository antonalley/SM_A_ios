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
    @State private var isCreateEventView = false
    @State private var isSearchView = false
    @State var searchText = ""
    @State var plans = [Plan]()
    @State var isPlanViewActive = false
    
//    func go_home(){
//        isPlanViewActive = false
//        isSearchView = false
//        isCreateEventView = false
//    }
    
    var body: some View{
        home_view
    }
    
    var home_view: some View {
        NavigationView{
            ZStack{
                HeaderView()
                VStack{
                    Spacer().frame(height:100)
                    NavigationLink(destination:CreatePlanView(isdosomethingview: $isCreateEventView), isActive: $isCreateEventView){
                        ZStack{
                            HStack{
                                Text("\tCreate an Event")
                                Spacer()
                            }
                            HStack{
                                Spacer()
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                                    .padding()
                                    .frame(alignment: .trailing)
                            }
                        }.foregroundColor(Color.white)
                            .frame(width:partial_width(percent: 0.95), height:70)
                            .background(Color(UIColor(named:"ButtonBlue") ?? .blue))
                            .cornerRadius(10)
                            .padding()
                            .shadow(radius:2, x:0, y:2)
                            .onTapGesture(){
                                //                                    isHomeView = false
                                isCreateEventView = true
                                
                            }
                    }
                    ScrollView{
                        
                        Text("Your Plans").foregroundColor(Color.gray)
                        ForEach(plans){ plan in
                            EventTitle(plan: plan).onAppear(){
                                get_calendar()
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
                    
                    
                }.onAppear(perform:get_calendar)
            }
        }.sheet(isPresented: $isSearchView, onDismiss: get_calendar){
            SearchView(isSearchView: $isSearchView)
        }
    }
    
    
    func get_calendar() {
        let authtoken = UserDefaults.standard.string(forKey: "authtoken") ?? ""
        guard let url = URL(string: "http://45.58.32.232:8000/plans/getuserplans/") else {
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
                        self.plans = [];
                        for plan in response{
                            let x = plan_from_data(plan_data: plan, interests: Array<InterestForPlan>());
                            self.plans.append(x);
                        }
                        
                    }
                    return
                }
            }
            
        }.resume()
        return
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
