//
//  AddBookView.swift
//  BookSwap
//
//  Created by Kris Reid on 24/12/2020.
//

import SwiftUI

struct AddBookView: View {
    
    @State private var showDetail = false
    
    @State private var showImagePicker: Bool = false
    @State private var image: Image? = Image(systemName: "camera.circle")

    @ObservedObject private var vm = BookViewModel()
    
    var body: some View {
        
        VStack {
            HStack {
                if showDetail {
                    Spacer()
                }
                AddBookButtonView(showDetail: self.$showDetail)
            }
            if showDetail {
                HStack {
                    VStack (spacing: 10) {
                        //BUTTON TO ADD PICTURE OF BOOK
                        Button(action: {
                            self.showImagePicker = true
                        }) {
                            image?
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
                                .font(.system(size: 10, weight: .ultraLight))
                                .frame(width: 180, height: 180)
                                .clipShape(Circle())
                        }.sheet(isPresented: self.$showImagePicker) {
                        PhotoCaptureView(showImagePicker: self.$showImagePicker, image:  self.$image)
                        }
                        
                        
                        //3 TEXT FIELDS
                        TextField("Enter book title", text: self.$vm.title)
                            .background(Color(.white))
                            .padding(.top, 15)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
                        
                        TextField("Enter author", text: self.$vm.author)
                            .background(Color(.white))
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))

                        TextField("Enter # pages", text: self.$vm.pageCount)
                            .keyboardType(.numberPad)
                            .onChange(of: vm.pageCount, perform: { value in
                                
                                if !(vm.pageCount.last?.isNumber ?? true) {
                                    vm.pageCount.removeLast()
                                }
//                                if vm.pageCount.count > 5 {
//                                    // error
//                                }
                            })
                            .background(Color(.white))
                            
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
                        
                        
                        //SAVE AND CLOSE BUTTON
                        Button(action: {
                            self.vm.postBook()
                            self.showDetail.toggle()
                        }, label: {
                            Text("Add Book")
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .background(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
                                .cornerRadius(5)
                        })
                        .padding(.top, 15)
                    }
                    .padding()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20)
        .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        .asTile()
    }
}

struct AddBookButtonView: View {
    
    @Binding var showDetail: Bool
    
    var body: some View {
        VStack {
            Button(action: {
                self.showDetail.toggle()
            }, label: {
                Image(systemName: "plus.circle")
                    .foregroundColor(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
                    .font(.system(size: showDetail ? 45 : 90, weight: .thin))
                    .rotationEffect(.degrees(showDetail ? 135 : 0))
                    .padding()
                    .animation(.spring())
            })
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
