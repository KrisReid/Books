//
//  SignInView.swift
//  BookSwap
//
//  Created by Kris Reid on 01/01/2021.
//

import SwiftUI
import GoogleSignIn

struct SignInView: View {
    
    @State var pulse = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Image(systemName: "books.vertical")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .foregroundColor(Color(#colorLiteral(red: 0.9999478459, green: 1, blue: 0.9998740554, alpha: 1)))
                    .padding(.top, 50)
                    .font(.system(size: 10, weight: .ultraLight))
                    .scaleEffect(pulse ? 1.2 : 1)
                    .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true).speed(0.8))
                    .onAppear() {
                        self.pulse.toggle()
                    }
                
                Text("Book Swap")
                    .font(.system(size: 60, weight: .light))
                    .foregroundColor(Color(#colorLiteral(red: 0.9999478459, green: 1, blue: 0.9998740554, alpha: 1)))
                    .padding(.top, 15)
                
                Spacer()
                
                VStack (spacing: 10) {
                    GoogleSignInButton()
                    FacebookSignInButton()
                    AppleSignInButton()
                }.padding(.bottom, 20)
            }
        }
    }
}

struct GoogleSignInButton: View {
    var body: some View {
        Button(action: {
            GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
            GIDSignIn.sharedInstance()?.signIn()
        }, label: {
            HStack {
                Image("google_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
                Text("Sign in with Google")
                    .foregroundColor(Color(#colorLiteral(red: 0.2588032484, green: 0.2744767964, blue: 0.2979655266, alpha: 1)))
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        })
        .frame(width: 260)
        .background(Color(#colorLiteral(red: 0.9999478459, green: 1, blue: 0.9998740554, alpha: 1)))
        .cornerRadius(8)
    }
}

struct FacebookSignInButton: View {
    var body: some View {
        Button(action: {
            //Do Something
        }, label: {
            HStack {
                Image("facebook_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
                Text("Sign in with Facebook")
                    .foregroundColor(Color(#colorLiteral(red: 0.2588032484, green: 0.2744767964, blue: 0.2979655266, alpha: 1)))
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        })
        .frame(width: 260)
        .background(Color(#colorLiteral(red: 0.9999478459, green: 1, blue: 0.9998740554, alpha: 1)))
        .cornerRadius(8)
    }
}

struct AppleSignInButton: View {
    var body: some View {
        Button(action: {
            //Do Something
        }, label: {
            HStack {
//                Image("apple_icon")
                Image(systemName: "applelogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                Text("Sign in with Apple")
                    .foregroundColor(Color(#colorLiteral(red: 0.2588032484, green: 0.2744767964, blue: 0.2979655266, alpha: 1)))
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        })
        .frame(width: 260)
        .background(Color(#colorLiteral(red: 0.9999478459, green: 1, blue: 0.9998740554, alpha: 1)))
        .cornerRadius(8)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
