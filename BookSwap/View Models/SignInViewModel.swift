//
//  SignInViewModel.swift
//  BookSwap
//
//  Created by Kris Reid on 02/01/2021.
//

import Foundation
import FirebaseAuth


class SignInViewModel: ObservableObject {
    
    @Published var uid: String = ""
    @Published var googleEmail: String = ""
    
    func SignIn (credential: AuthCredential) {
        
        //Sign into Firebase
        Auth.auth().signIn(with: credential) { (result, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }

            self.googleEmail = result?.user.email ?? ""
            self.uid = Auth.auth().currentUser?.uid ?? ""
            
        }
    }
}
