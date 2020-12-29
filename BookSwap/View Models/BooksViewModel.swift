//
//  BooksViewModel.swift
//  BookSwap
//
//  Created by Kris Reid on 27/12/2020.
//

import Foundation
import FirebaseDatabase


class BookViewModel: ObservableObject {
    
    @Published var books = [Book]()
    
    init() {
        fetchBooks()
    }
    
    func fetchBooks() {
        let bookRef = Database.database().reference()
        let bookRefQuery = bookRef.queryOrderedByKey()

        bookRefQuery.observe(.value) { (snapshot) in
            for item in snapshot.children {
                guard let snapshot = item as? DataSnapshot else { continue }
                guard let book = Book(snapshot) else { continue }
                self.books.insert(book, at: 0)
            }
        }
    }
}




