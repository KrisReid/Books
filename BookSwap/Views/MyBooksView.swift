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
    
    @State private var showDetail = false
    @ObservedObject private var vm = BookViewModel()
    
    init() {
        
    }
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)), Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
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




