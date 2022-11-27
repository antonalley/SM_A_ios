//
//  userInfo.swift
//  SM_A_ios
//
//  Created by Anton Alley on 9/14/22.
//

import Foundation

struct Plan: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var location: Location
    var time: Date
    var who: WhoDetail
    var user_is_going: Bool
}

class Plans: ObservableObject {
    @Published var items = [Plan]()
}

struct Plan_data_upload: Codable, Hashable {
    var id: Int?
    var name: String
    var when: String
    var latitude: Float
    var longitude: Float
    var location_name: String
    var num_people: Int
    var host: Int
    var people_going: [Int]

}

struct Plan_data: Codable, Hashable {
    var id: Int?
    var name: String
    var when: String
    var latitude: Float
    var longitude: Float
    var location_name: String
    var num_people: Int
    var host: USER
    var people_going: [USER]

}

func plan_from_data(plan_data: Plan_data, interests: [InterestForPlan])-> Plan {
    let location = Location(name:plan_data.location_name, x:plan_data.longitude, y: plan_data.latitude)
    let qq_who = WhoDetail(interests:interests, min_people: plan_data.num_people, num_going: plan_data.people_going.count, people_going: plan_data.people_going, host: plan_data.host)
    var user_is_going = false;
    
    plan_data.people_going.forEach(){p in
        if p.id == Int(UserDefaults.standard.string(forKey: "personID") ?? "-1") ?? -1 {
            user_is_going = true
        }
    }
        
    return Plan(id:plan_data.id ?? -1, name:plan_data.name, location:location, time: getDateFrom(date:plan_data.when), who:qq_who, user_is_going: user_is_going);
}
                                            

struct WhoDetail: Codable, Hashable {
    var interests: Array<InterestForPlan>
    var skill: Int? // 1- Beginner 2- Intermediate 3- Advanced
    var radius: Float? // The radius that encompasses who is invited
    var center: Location?
    var min_people: Int?
    var max_people: Int?
    var num_going: Int?
    var people_going: [USER]
    var host: USER?
}

//func get_user(id: Int){
//    var user: USER
//    let authtoken = UserDefaults.standard.string(forKey: "authtoken") ?? ""
//    guard let url = URL(string: "http://45.58.32.232:8000/users/?id=\(id)") else {
//        print("api is down")
//        return
//    }
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.addValue("Token \(authtoken)", forHTTPHeaderField: "Authorization")
//    URLSession.shared.dataTask(with: request) { data, response, error in
//        if let data = data {
//            if let response = try? JSONDecoder().decode(USER.self, from: data) {
//                DispatchQueue.main.async {
//                    user = response;
//                    }
//
//                }
//                return
//            }
//        }
//
//    }.resume()
//
//    return user
//}

struct USER: Codable, Hashable, Identifiable {
    var id: Int
    var username: String
    var first_name: String?
    var last_name: String?
    var email: String?
}

struct Location: Codable, Hashable {
    var name: String
    var x: Float
    var y: Float
}

struct InterestForPlan: Codable, Hashable, Identifiable{
    var id: Int
    var name: String
    var weight: Int
    var num_people_included: Int
}

struct Interest: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var open_response: Bool
    var response: String?
//    var isChecked: Bool?
}

//struct InterestFormResponse: Codable, Hashable, Identifiable {
//    var id: Int
//    var
//}

struct LoginRequest: Codable, Hashable {
    var username: String
    var password: String
}

struct RegisterRequest: Codable, Hashable {
    var username: String
    var password: String
    var email: String
    var first_name: String
    var last_name: String
}


struct User: Codable, Hashable {
    let personID: Int
    var username: String
    var authtoken: String
    var success: Bool
}


extension Date {
    func formatDate() -> String {
        // Get date in easy to read form
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEE, MMM d")
        let x = dateFormatter.string(from: self)
        return x
    }
    func formatDateWTime() -> String {
        // Get date in easy to read form with hour minut
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEE, MMM d, hh:mm")
        let x = dateFormatter.string(from: self)
        return x
    }
    func prepareDate() -> String {
        // For sending Date to server
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        var timeZone: TimeZone { get set }
        return dateFormatter.string(from: self)
    }
}

func getDateFrom(date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    // TODO handle error when unable to convert, right now it will return the current date
    let newDate = dateFormatter.date(from: date) ?? Date()
    return newDate
}

