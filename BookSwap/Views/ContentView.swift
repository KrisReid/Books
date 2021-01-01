//
//  ContentView.swift
//  BookSwap
//
//  Created by Kris Reid on 23/12/2020.
//

import SwiftUI
import GoogleSignIn

struct ContentView: View {
    
    @ObservedObject var info : AppDelegate
    
    var body: some View {
        
        VStack {
            
            Button(action: {
                
                GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
                
                GIDSignIn.sharedInstance()?.signIn()
                
            }, label: {
                Text("Sign In")
            })
            
            
            if info.email.isEmpty {
                Text("Hello - i am empty")
            } else {
                Text(info.email)
            }
            
            
            Button(action: {
                GIDSignIn.sharedInstance().signOut()
                info.email = ""
            }) {
                Text("Sign Out")
            }
            
        }.onAppear {
            GIDSignIn.sharedInstance().restorePreviousSignIn()
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



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
