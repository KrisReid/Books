//
//  BookSwapApp.swift
//  BookSwap
//
//  Created by Kris Reid on 23/12/2020.
//

import Firebase
import SwiftUI

@main
struct BookSwapApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
