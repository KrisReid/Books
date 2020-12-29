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
    
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//  var window: UIWindow?
//
//    internal func application(_ application: UIApplication,
//    didFinishLaunchingWithOptions launchOptions:
//        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//    FirebaseApp.configure()
//
//    return true
//  }
//}
