//
//  BooksViewModel.swift
//  BookSwap
//
//  Created by Kris Reid on 27/12/2020.
//

import Foundation
import FirebaseDatabase


//struct BookParser: Hashable {
//
//    var book = Book(title: "", author: "", publisher: "", imageUrl: "", pageCount: 0)
//
//    //PASS A SNAPSHOT INTO THE MODEL AND THEN GET BACK THE PARSED VALUES
//    init?(_ snapshot: DataSnapshot) {
//
//        guard let value = snapshot.value as? [String: Any] else { return nil }
//
//        book.title = value["title"] as? String ?? ""
//        book.author = value["author"] as? String ?? ""
//        book.imageUrl = value["imageUrl"] as? String ?? ""
//        book.pageCount = value["pageCount"] as? Int ?? 0
//        book.publisher = value["publisher"] as? String ?? ""
//    }
//}


class BookViewModel: ObservableObject {
    
    @Published var books = [Book]()
    
    @Published var title: String = ""
    @Published var author: String = ""
    @Published var publisher: String = ""
    @Published var imageUrl: String = ""
    @Published var pageCount: String = ""
    
    init() {
        fetchBooks()
    }
    
    func fetchBooks() {
        let bookRef = Database.database().reference()
        let bookRefQuery = bookRef.queryOrderedByKey()
 
        bookRefQuery.observe(.value) { (snapshot) in
            
            self.books.removeAll()
            
            for item in snapshot.children {
                guard let snapshot = item as? DataSnapshot else { continue }
                guard let book = Book(snapshot) else { continue }
                self.books.insert(book, at: 0)
            }
        }
    }
    

    func postBook() {
        
        let numPages = Int(self.pageCount)

        let bookDictionary : [String:Any] = [
            "title" : self.title,
            "author" : self.author,
            "publisher" : "Can't be assed",
            "imageUrl" : "Can't be assed",
            "pageCount" : numPages ?? 99999
        ]
        Database.database().reference().childByAutoId().setValue(bookDictionary)
    }
}
