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
    @State var what = ""
    @State var when = Date()
    @State var where_ = ""
    @State var who = ""
    @State var who_interests = [
        InterestForPlan(id: 1, name: "volleyball", weight: 10, num_people_included: 10),
        InterestForPlan(id: 2, name: "music", weight: 4, num_people_included: 100),
        InterestForPlan(id: 3, name: "One Republic", weight: 5, num_people_included: 4),
        InterestForPlan(id: 4, name: "music", weight: 4, num_people_included: 100),
        InterestForPlan(id: 5, name: "One Republic", weight: 5, num_people_included: 4),
        InterestForPlan(id: 6, name: "volleyball", weight: 10, num_people_included: 10),
        ]
    
    @State var isdosomethingview = true

    @State var isMap = false
    @State var formWidth = CGFloat(300)
    @EnvironmentObject var search_service: LocalSearchService
    
    
    
    var body: some View {
        if isdosomethingview{
            createplanView
        } else {
            HomeView()
        }
    }
    var createplanView: some View {
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
                        Image(systemName: "calendar.badge.plus")
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
                        Text("Where?")
//                        Text(search_service.landmark != nil ? search_service.landmark!.name : "Where?")
                    }.onTapGesture {
                        isMap = true
                    }.padding()
                        .frame(width:formWidth, height:50)
                        .background(Color(UIColor(named:"BoxedColor") ?? .black))
                        .cornerRadius(10)
                    

                    WrappingHStack(get_who_info(), id:\.self, lineSpacing: 10) { interest in
                        if interest == "Who?" {
                            Text(interest)
                                .padding(5)
                        } else if interest == "Add+" {
                            Text(interest)
                                .padding(.trailing, 10)
                                .padding(.leading, 10)
                                .padding(5)
                                .background(Color.orange)
                                .cornerRadius(20)
                        } else {
                            Text(interest)
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
                        // Create dosumm with info
                        //                    var new_event = Plan(id: Int.random(in: 100...10000),name:self.what, location:self.where_, time:self.when, who:self.who)
                        isdosomethingview = false
                    }.foregroundColor(Color.white)
                        .frame(width:formWidth, height:50)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .padding()
                    
                    
                }
            }.sheet(isPresented: $isMap){
                ChooseLocationView()
            }
        }
        
    }
    
    func get_who_info() -> Array<String> {
        var x = Array<String>()
        x.append("Who?")
        for interest in who_interests {
            x.append(interest.name)
        }
        x.append("Add+")
        
        return x
    }
    
    
}

struct CreeatePlanView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlanView()
    }
}


