//
//  SwapBooksView.swift
//  BookSwap
//
//  Created by Kris Reid on 24/12/2020.
//

import SwiftUI

struct SwapBooksView: View {
    var body: some View {
        NavigationView {
            
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
            }
        }
    }
}

struct SwapBooksView_Previews: PreviewProvider {
    static var previews: some View {
        SwapBooksView()
    }
}
