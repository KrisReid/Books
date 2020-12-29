//
//  AddBookViewModel.swift
//  BookSwap
//
//  Created by Kris Reid on 24/12/2020.
//

import Foundation

class AddBookViewModel: ObservableObject {
    
//    @Published var book: Book?
    
    @Published var title: String = ""
    @Published var author: String = ""
    @Published var publisher: String = ""
    @Published var ImageUrl: String = ""
    @Published var pageCount: String = ""
}
