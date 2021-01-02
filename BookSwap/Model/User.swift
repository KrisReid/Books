//
//  User.swift
//  BookSwap
//
//  Created by Kris Reid on 02/01/2021.
//

import Foundation

struct User: Codable {
    var uid: String
    var email: String?
    var displayName: String?

    init(uid: String, email: String?, displayName: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}
