//
//  AddInterests.swift
//  SM_A_ios
//
//  Created by Anton Alley on 9/17/22.
//

import SwiftUI

struct InterestView: View {
    var interest: Interest
    @Binding var selectedInterests: Set<Int>
    
    var isSelected: Bool {
        selectedInterests.contains(interest.id)
    }
    
    var body: some View {
        HStack{
//            Color.orange.ignoresSafeArea()
            Text(interest.name)
                .padding()
            Spacer()
            if (self.isSelected){
                Image(systemName:"checkmark")
                    .foregroundColor(Color.orange)
            }
        }.onTapGesture{
            if (self.isSelected){
                self.selectedInterests.remove(self.interest.id)
            } else {
                self.selectedInterests.insert(self.interest.id)
            }
        }
    }
}

struct AddInterests: View {
    let username = UserDefaults.standard.string(forKey: "username") ?? ""
    let authtoken = UserDefaults.standard.string(forKey: "authtoken") ?? ""
    @State private var interests: [Interest] = [
        Interest(id:5, name:"test", open_response:false, response:""),
        Interest(id:6, name:"test2", open_response:false, response:"")
    ]
    @State private var responses: [String] = []
    @State var isToggled: Bool = true
    @State var isInterestView = true
    @State var selectedInterests = Set<Int>()
    
    var body: some View{
        if (isInterestView){
            addInterestView
        } else {
            HomeView()
        }
    }
    var addInterestView: some View {
        NavigationView {
//            Color.orange.ignoresSafeArea()
            ZStack {
//                Color.orange.ignoresSafeArea()
                VStack{
//                    Color.orange.ignoresSafeArea()
                    List(interests, selection: $selectedInterests){ interest in
//                        Color.orange.ignoresSafeArea()
                        InterestView(interest: interest, selectedInterests: self.$selectedInterests)
                            
                    }.navigationBarTitle("Select Interests")
                        .foregroundColor(Color.orange)
                    Button("Add interests"){
                        // TODO
                        isInterestView = false
                    }.foregroundColor(Color.white)
                        .frame(width:300, height:50)
                        .background(Color.orange.opacity(0.8))
                        .cornerRadius(10)
                        .padding()
                }.onAppear {
                    self.getInterests()
                }
            }
        }
        
        
    }
    
    func getInterests() {
        guard let url = URL(string: "http://10.3.114.18/user/get_interests/") else {
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
                if let response = try? JSONDecoder().decode([Interest].self, from: data) {
                    DispatchQueue.main.async {
                        interests = response;
//                        for interest in interests{
//                            interest.isChecked = false
//                        }
                        print(interests)
                        
                    }
                    return
                }
            }
            
        }.resume()
    }
}

struct AddInterests_Previews: PreviewProvider {
    static var previews: some View {
        AddInterests()
    }
}
