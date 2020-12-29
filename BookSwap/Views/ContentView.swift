//
//  ContentView.swift
//  BookSwap
//
//  Created by Kris Reid on 23/12/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MyBooksView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("My Bookcase")
                }
                .tag(0)
            SwapBooksView()
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
