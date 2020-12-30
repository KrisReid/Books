//
//  Book.swift
//  BookSwap
//
//  Created by Kris Reid on 24/12/2020.
//

import Foundation
import FirebaseDatabase


struct Book: Hashable {
    
    let title, author, publisher, imageUrl: String
    let pageCount: Int
    
    //PASS A SNAPSHOT INTO THE MODEL AND THEN GET BACK THE PARSED VALUES
    init?(_ snapshot: DataSnapshot) {

        guard let value = snapshot.value as? [String: Any] else { return nil }

        self.title = value["title"] as? String ?? ""
        self.author = value["author"] as? String ?? ""
        self.imageUrl = value["imageUrl"] as? String ?? ""
        self.pageCount = value["pageCount"] as? Int ?? 0
        self.publisher = value["publisher"] as? String ?? ""
    }
    
}
