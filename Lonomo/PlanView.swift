//
//  PlanView.swift
//  Lonomo
//
//  Created by Anton Alley on 10/10/22.
//

import SwiftUI
import WrappingHStack

struct PlanView: View {
    var plan: Plan
    @Binding var isPlanViewActive: Bool
    var go_home: () -> ()
    
    var body: some View {
        ZStack{
            HeaderView()
            
            VStack{
                Spacer().frame(height:60)
                
                HStack{
                    Text(plan.name).font(.largeTitle).padding()
                    Spacer()
                }.padding()
                HStack{
                    Text("When").font(.title2).bold()
                    Image(systemName: "calendar")
                    Text(plan.time.formatDateWTime())
                }.padding()
                HStack{
                    Text("Who").font(.title2).bold()
                    List(plan.who.people_going, id:\.id ){ user in
                        Text(user.username)
                    }.frame(height:CGFloat(150))
//                    ScrollView{
//                        ForEach(plan.who.interests, id:\.self) { interest in
//                            Text(interest.name)
//                                .padding(.trailing, 10)
//                                .padding(.leading, 10)
//                                .padding(5)
//                                .background(Color.black.opacity(0.2))
//                                .cornerRadius(20)
//
//                        }
//                    }.frame(height:CGFloat(150))
                        
                }.padding()
//                    .frame(width:280, height:300)
                
//                Text()
                HStack{
                    Text("Where").font(.title2).bold()
                    Text(plan.location.name)
                    Image(systemName: "mappin.circle")
                    
                }.padding()
                // TODO add map section
                
                
                Spacer()
                ZStack{
                    Text(plan.user_is_going ? "Back Out" : "Ask to join")
                    HStack{
                        Spacer()
                        Image(systemName: plan.user_is_going ? "arrow.up.right" : "arrow.right")
                            .padding()
                            .imageScale(.large)
                            .foregroundColor(.black.opacity(0.3))
                    }
                    
                }.frame(width:partial_width(percent: 0.95), height:50)
                    .background(plan.user_is_going ? Color.red.opacity(0.5) : Color(UIColor(named:"LonomoOrange") ?? .orange))
                    .cornerRadius(10)
                    .onTapGesture{
                        join_or_leave(is_going: plan.user_is_going, plan_id: plan.id)
                        //                        self.presentationMode.wrappedValue.dismiss()
                        go_home()
                    }
            }
            
            
            
        }.onAppear(){
//            print("Plan Loaded: \(plan.name)")
        }
    }
//    TODO
//    var map_sectional: some View {
//        Map()
//    }
    func leaveView(){
        isPlanViewActive = false
    }
    
    func join_or_leave(is_going: Bool, plan_id: Int){
        let url: String
        if is_going {
            url = "/plans/leave_event/"
        } else {
            url = "/plans/request_join_event/"
        }
        
        guard let url = URL(string: "http://45.58.32.232:8000\(url)") else {
            print("api is down")
            return
        }
        
        guard let encoded = try? JSONEncoder().encode(plan_id) else {
                    print("failed to encode")
                    return
                }
                
        let authtoken = UserDefaults.standard.string(forKey: "authtoken") ?? ""
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = encoded
        request.addValue("Token \(authtoken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return; }
            
            if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
//                isdosomethingview = false
//                showToast = true
                go_home()
                isPlanViewActive = false
            }
            return
            
        }.resume()
        
        return;
    }
}

//struct PlanView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanView(isPlanViewActive: true)
//    }
//}
