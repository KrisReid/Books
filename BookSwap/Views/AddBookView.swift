//
//  AddBookView.swift
//  BookSwap
//
//  Created by Kris Reid on 24/12/2020.
//

import SwiftUI

struct AddBookView: View {
    
//    @Binding var showDetail: Bool
    @State private var showDetail = false
    
    @State private var showImagePicker: Bool = false
    @State private var image: Image? = Image(systemName: "camera.circle")

    @ObservedObject private var vm = AddBookViewModel()
    
    var body: some View {
        HStack {
            if showDetail {

                VStack (spacing: 10) {
//                    Image(systemName: "book.circle")
//                        .resizable()
//                        .scaledToFill()
//                        .foregroundColor(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)))
//                        .font(.system(size: 10, weight: .ultraLight))
//                        .frame(width: 180, height: 180)
//                        .cornerRadius(90)
                    
                    VStack {
                        Button(action: {
                            self.showImagePicker = true
                        }) {
                            image?
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)))
                                .font(.system(size: 10, weight: .ultraLight))
                                .frame(width: 180, height: 180)
                                .clipShape(Circle())
                        }
                    }.sheet(isPresented: self.$showImagePicker) {
                        PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)
                    }

                    
                    TextField("Enter book title", text: self.$vm.title)
                        .background(Color(.white))
                        .padding(.top, 15)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)))
                    
                    TextField("Enter author", text: self.$vm.author)
                        .background(Color(.white))
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)))
                    
                    TextField("Enter # pages", text: self.$vm.pageCount)
                        .background(Color(.white))
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)))

                    
                    Button(action: {
                        //SAVE THE BOOK AND LOAD
                    }, label: {
                        Text("Add Book")
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 100))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .background(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)))
                    })
                    .padding(.top, 15)

                }
                .padding(10)
                .frame(width: UIScreen.main.bounds.midX)
                
                Spacer()
                
            }
            VStack {
                Button(action: {
                    self.showDetail.toggle()
                }, label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)))
                        .font(.system(size: 90, weight: .thin))
                        .rotationEffect(.degrees(showDetail ? 135 : 0))
                        .scaleEffect(showDetail ? 0.5 : 1)
                        .padding()
                        .animation(.spring())
                })
                if showDetail {
                    Spacer()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20)
        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        .asTile()
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}