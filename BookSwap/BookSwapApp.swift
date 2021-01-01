//
//  BookSwapApp.swift
//  BookSwap
//
//  Created by Kris Reid on 23/12/2020.
//

import Firebase
import SwiftUI
import GoogleSignIn
import FirebaseAuth

@main
struct BookSwapApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(user: self.delegate)
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, ObservableObject {
    
//    @Published var user: FirebaseAuth.User?
    
    @Published var email = ""
    @Published var displayName = ""
    @Published var photoURL = URL(string: "")
    @Published var phoneNumber = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        //Initialising Firebase
        FirebaseApp.configure()
        
        //Initialising Google
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        // Perform any operations when the user disconnects from app here.
        if error != nil {
            print(error.localizedDescription)
            return
        }

        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)

        
        //Sign into Firebase
        Auth.auth().signIn(with: credential) { (result, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
//            self.user = result?.user
            
            self.email = result?.user.email ?? ""
            self.displayName = result?.user.displayName ?? ""
            self.photoURL = result?.user.photoURL ?? URL(string: "")
            self.phoneNumber = result?.user.phoneNumber ?? ""
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print(error.localizedDescription)
    }
    
}
