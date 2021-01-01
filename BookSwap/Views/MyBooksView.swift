//
//  MyBooksView.swift
//  BookSwap
//
//  Created by Kris Reid on 24/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseDatabase

struct MyBooksView: View {
    
//    @State private var showDetail = false
    @ObservedObject private var vm = BookViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    var body: some View {
        NavigationView {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                ScrollView (.vertical, showsIndicators: false) {
                    VStack (spacing: 10  ) {
                        
                        AddBookView()

                        ForEach(vm.books, id: \.self) { book in
                            IndividualBookView(book: book)
                        }
                    }
                    .padding(.top, 50)
                }
            }
            .navigationTitle("My Books")
        }
    }
}

struct MyBooksView_Previews: PreviewProvider {
    static var previews: some View {
        MyBooksView()
    }
}




