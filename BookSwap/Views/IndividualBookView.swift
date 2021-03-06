//
//  IndividualBookView.swift
//  BookSwap
//
//  Created by Kris Reid on 24/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct IndividualBookView: View {
    
    let book: Book
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            HStack {
                WebImage(url: URL(string: book.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 180)
                    .clipped()
                    .cornerRadius(5)
                
                VStack (alignment: .leading, spacing: 10) {
                    Text(book.title)
                        .font(.title)
                        .lineLimit(1)
                    Text(book.author)
                        .font(.title2)
                        .lineLimit(1)
                    Spacer()
                    Text("\(book.pageCount) pages")
                        .font(.title3)
                        .lineLimit(1)
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    
                }
                Spacer()
            }.padding(10)
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: 200)
        .asTile()
    }
}

//struct IndividualBookView_Previews: PreviewProvider {
//    static var previews: some View {
//        IndividualBookView()
//    }
//}
