//
//  DoSomethingView.swift
//  SM_A_ios
//
//  Created by Anton Alley on 9/29/22.
//
import MapKit
import SwiftUI
import WrappingHStack

struct CreatePlanView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var what = ""
    @State var when = Date()
    @State var where_ = ""
    @State var who = ""
    @State var numPeople = 2
    @State var who_interests = Array<InterestForPlan>()
    @State var interests_available = [
        InterestForPlan(id: 1, name: "Volleyball", weight: 10, num_people_included: 10),
        InterestForPlan(id: 2, name: "Programming", weight: 4, num_people_included: 100),
        InterestForPlan(id: 3, name: "Surfaces", weight: 5, num_people_included: 4),
        InterestForPlan(id: 4, name: "Music", weight: 4, num_people_included: 100),
        InterestForPlan(id: 5, name: "One Republic", weight: 5, num_people_included: 4),
        InterestForPlan(id: 6, name: "Pickleball", weight: 10, num_people_included: 10),
        InterestForPlan(id: 7, name: "basketball", weight: 3, num_people_included: 20),
        ]
    
    @Binding var isdosomethingview: Bool

    @State var isMap = false
    @State var formWidth = CGFloat(300)
    @EnvironmentObject var search_service: LocalSearchService
    
    @State var isAddInterest = false
    @State var interestFind = ""
    
    @State var confirmSending = false
    
    var body: some View {
        ZStack{
//            HeaderView()
            NavigationView{
                VStack {
                    Text("Create Plan").font(.title)
                    TextField("What?", text:$what)
                        .padding()
                        .frame(width:formWidth, height:50)
                        .background(Color(UIColor(named:"BoxedColor") ?? .black))
                        .cornerRadius(10)

                    HStack{
//                        Image(systemName: "calendar.badge.plus")
                        Image("calendar-solid").resizable().scaledToFit()
                        DatePicker("", selection: $when)
                            .datePickerStyle(CompactDatePickerStyle())
                            .clipped()
                            .labelsHidden()
                    }.padding()
                        .frame(width:formWidth, height:50)
                        .background(Color(UIColor(named:"BoxedColor") ?? .black))
                        .cornerRadius(10)
                    
                    HStack{
                        Image(systemName: "map")
//                        Text("Where?")
                        Text(search_service.landmark != nil ? search_service.landmark!.name : "Where?")
                    }.onTapGesture {
                        isMap = true
                    }.padding()
                        .frame(width:formWidth, height:50)
                        .background(Color(UIColor(named:"BoxedColor") ?? .black))
                        .cornerRadius(10)
                    

                    WrappingHStack(get_who_info(), id:\.self, lineSpacing: 10) { interest in
                        if interest.name == "Who?" {
                            Text(interest.name)
                                .padding(5)
                        } else if interest.name == "Add+" {
                            Text(interest.name)
                                .padding(.trailing, 10)
                                .padding(.leading, 10)
                                .padding(5)
                                .background(Color.orange)
                                .cornerRadius(20)
                                .onTapGesture(){
                                    isAddInterest = true
                                }
                        } else {
                            Text(interest.name)
                                .padding(.trailing, 10)
                                .padding(.leading, 10)
                                .padding(5)
                                .background(Color.black.opacity(0.2))
                                .cornerRadius(20)
                                
                        }
                    }.padding()
                        .frame(width:formWidth)
                        .background(Color(UIColor(named:"BoxedColor") ?? .black))
                        .cornerRadius(10)
                    
                    Button("Send Plan"){
                        confirmSending = true
                    }.foregroundColor(Color.white)
                        .frame(width:formWidth, height:50)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .padding()
                    
                        .confirmationDialog("confirm", isPresented: $confirmSending){
                            Button("Create Event and Auto-Invite People"){
                                send_plan()
                            }
                        }message: {
                            Text("Creating this event will automatically invite people that have similar hobbies and interests and you and that pertain to this event")
                        }
                    
                    
                }
            }.sheet(isPresented: $isMap){
                ChooseLocationView()
            }.sheet(isPresented: $isAddInterest){
                if #available(iOS 16.0, *) {
                    add_interest_view
                        .presentationDetents([.fraction(CGFloat(0.4))])
                } else {
                    // Fallback on earlier versions
                    add_interest_view
                }
            }
        }
        
    }
    
    var add_interest_view: some View {
        VStack{
            HStack{
                Stepper("Group Size: \(numPeople)", value:$numPeople)
            }.frame(width:partial_width(percent: 0.50), height:50)
                .padding(.top)

            HStack{
                Image(systemName: "magnifyingglass").padding()
                TextField("Find", text: $interestFind)
                    Spacer()
                }.foregroundColor(Color.gray)
                .frame(width:partial_width(percent: 0.70), height:50)
                    .background(colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1))
                    .cornerRadius(10)
//                    .padding()
            
            ScrollView{
                WrappingHStack(get_searched_interests(), id:\.self, lineSpacing: 10) { interest in
                    Text(interest.name)
                        .padding(.trailing, 10)
                        .padding(.leading, 10)
                        .padding(5)
                        .background(who_interests.contains(interest) ? Color.blue.opacity(0.5) : Color.black.opacity(0.2))
                        .cornerRadius(20)
                        .onTapGesture(){
                            who_interests.append(interest)
                        }
                    
                }.padding()
                    .frame(width:formWidth)
            }
            
            Spacer()
        }
    }
    
    func get_searched_interests() -> Array<InterestForPlan> {
        var x = Array<InterestForPlan>()
        for interest in interests_available {
            if interest.name.contains(interestFind) || interestFind=="" {
                x.append(interest)
            }
        }
        return x
    }
    
    func get_who_info() -> Array<InterestForPlan> {
        var x = Array<InterestForPlan>()
        x.append(InterestForPlan(id: 0, name: "Who?", weight: 0, num_people_included: 0))
        x.append(InterestForPlan(id: -2, name: "\(numPeople) People", weight: 0, num_people_included: numPeople))
        for interest in who_interests {
            x.append(interest)
        }
        x.append(InterestForPlan(id: -1, name: "Add+", weight: 0, num_people_included: 0))
        
        return x
    }
    
    func send_plan() {
        let this_plan = Plan_data_upload(name:what, when:when.prepareDate(), latitude:Float(search_service.landmark?.coordinate.latitude ?? 0.0), longitude: Float(search_service.landmark?.coordinate.longitude ?? 0.0), location_name:search_service.landmark?.name ?? "Unnamed", num_people:numPeople, host:Int(UserDefaults.standard.string(forKey: "personID") ?? "0") ?? 0, people_going:[Int(UserDefaults.standard.string(forKey: "personID")  ?? "0") ?? 0]
        );
        
        guard let url = URL(string: "http://45.58.32.232:8000/plans/getuserplans/") else {
            print("api is down")
            return
        }
        
        guard let encoded = try? JSONEncoder().encode(this_plan) else {
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
                isdosomethingview = false
            }
            return
            
        }.resume()
        
        return;
        
    }
    
    
}

//struct CreeatePlanView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatePlanView()
//    }
//}


