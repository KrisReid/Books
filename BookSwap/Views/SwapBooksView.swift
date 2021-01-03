//
//  SwapBooksView.swift
//  BookSwap
//
//  Created by Kris Reid on 24/12/2020.
//

import SwiftUI
import GoogleSignIn
import SDWebImageSwiftUI
import FirebaseAuth

struct SwapBooksView: View {
    
    @ObservedObject var user : AppDelegate
    @Binding var appleUser: User
    
    var body: some View {
        NavigationView {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
//                    WebImage(url: URL(string: "\(user.googlePhotoURL!)"))
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 100, height: 100)
//                        .clipped()
//                        .cornerRadius(100)
//
//                    Text("Welcome \(user.googleDisplayName)")
//                        .foregroundColor(.white)
//                    
//                    Spacer()
                    
                    
                    Button(action: {
                        GIDSignIn.sharedInstance().signOut()

                        do {
                            try Auth.auth().signOut()
                        } catch {
                            print("Error Signing Out")
                        }
                        
                        user.uid = ""
                        user.user?.uid = ""
                        appleUser.uid = ""
                        
                    }) {
                        Text("Sign Out")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}


//struct SwapBooksView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwapBooksView(user: AppDelegate.self)
//    }
//}
