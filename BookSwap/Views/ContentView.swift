//
//  ContentView.swift
//  BookSwap
//
//  Created by Kris Reid on 23/12/2020.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth

struct ContentView: View {
    
    @ObservedObject var user: AppDelegate
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                    
                if !user.email.isEmpty {
                    TabView {
                        MyBooksView()
                            .tabItem {
                                Image(systemName: "books.vertical.fill")
                                Text("My Bookcase")
                            }
                            .tag(0)
                        SwapBooksView(user: user)
                            .tabItem {
                                Image(systemName: "shuffle")
                                Text("Book Exchange")
                            }
                            .tag(1)
                    }
                    .accentColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                    .onAppear() {
                        UITabBar.appearance().barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    }

                } else {
                    SignInView()
                }
            }
            .onAppear {
                GIDSignIn.sharedInstance().restorePreviousSignIn()
            }
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//
//    }
//}
