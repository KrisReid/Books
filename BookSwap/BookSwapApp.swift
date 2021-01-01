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
    
//    init() {
//        FirebaseApp.configure()
//    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(info: self.delegate)
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, ObservableObject {
    
    @Published var email = ""
    
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
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                            accessToken: authentication.accessToken)

        
        //Sign into Firebase
        Auth.auth().signIn(with: credential) { (result, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
//            NotificationCenter.default.post(name: NSNotification.Name("Sign In"), object: nil)
            
            self.email = (result?.user.email)!
            print(result?.user.email!)
                                                
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
        print(error.localizedDescription)
        
    }

}

