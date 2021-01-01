//
//  ContentView.swift
//  BookSwap
//
//  Created by Kris Reid on 23/12/2020.
//

import SwiftUI
import GoogleSignIn
import SDWebImageSwiftUI

struct ContentView: View {
    
    @ObservedObject var info : AppDelegate
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                GoogleSignInButton()

                if !info.email.isEmpty {
                    Text("Welcome \(info.displayName)")
                        .foregroundColor(.white)
                    
                    WebImage(url: URL(string: "\(info.photoURL!)"))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                        .cornerRadius(100)
                }
                
                Button(action: {
                    GIDSignIn.sharedInstance().signOut()
                    info.email = ""
                }) {
                    Text("Sign Out")
                        .foregroundColor(.white)
                }
            }
            .onAppear {
                GIDSignIn.sharedInstance().restorePreviousSignIn()
            }
        }
        
            

        
//        TabView {
//            MyBooksView()
//                .tabItem {
//                    Image(systemName: "books.vertical.fill")
//                    Text("My Bookcase")
//                }
//                .tag(0)
//            SwapBooksView()
//                .tabItem {
//                    Image(systemName: "shuffle")
//                    Text("Book Exchange")
//                }
//                .tag(1)
//        }
//        .accentColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
//        .onAppear() {
//            UITabBar.appearance().barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        }
        
    }
}




struct GoogleSignInButton: View {
    var body: some View {
        
        Button(action: {
            
            GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
            
            GIDSignIn.sharedInstance()?.signIn()
            
        }, label: {
            HStack {
                Image("google_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
                Text("Sign in with Google")
                    .foregroundColor(Color(#colorLiteral(red: 0.2588032484, green: 0.2744767964, blue: 0.2979655266, alpha: 1)))
            }
            .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
            
        })
        .background(Color(#colorLiteral(red: 0.9999478459, green: 1, blue: 0.9998740554, alpha: 1)))
        .cornerRadius(20)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        GoogleSignInButton()
        
    }
}
