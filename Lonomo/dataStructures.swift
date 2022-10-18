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
    var time: String
    var who: WhoDetail?
    var user_is_going: Bool
}

struct WhoDetail: Codable, Hashable {
    var interests: Array<InterestForPlan>
    var skill: Int? // 1- Beginner 2- Intermediate 3- Advanced
    var radius: Float? // The radius that encompasses who is invited
    var center: Location
    var min_people: Int
    var max_people: Int
    var num_going: Int
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
