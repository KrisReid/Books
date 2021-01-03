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
//            ContentView()
//            ContentView(user: self.delegate)
            SignInView(user: self.delegate, appleUser: delegate.user ?? User(uid: "", email: "", displayName: ""))
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, ObservableObject {
//class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    @Published var user: User?
    @Published var uid: String = ""
    
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
        Auth.auth().signIn(with: credential) { (user, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            if let user = user {
                self.uid = user.user.uid
                self.user = User(uid: user.user.uid, email: user.user.email, displayName: user.user.displayName)
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print(error.localizedDescription)
    }
    
}
