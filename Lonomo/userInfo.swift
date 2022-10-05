//
//  userInfo.swift
//  SM_A_ios
//
//  Created by Anton Alley on 9/14/22.
//

import Foundation

struct Dosumm: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var location: String
    var time: String
    var who: String // TODO Will change, maybe a different struct?
    
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
