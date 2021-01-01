//
//  User.swift
//  BookSwap
//
//  Created by Kris Reid on 01/01/2021.
//

import Foundation

struct User: Hashable {
    
    let email, displayName, phoneNumber: String
    let photoURL: URL
}
