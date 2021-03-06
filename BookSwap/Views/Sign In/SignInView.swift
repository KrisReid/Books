//
//  SignInView.swift
//  BookSwap
//
//  Created by Kris Reid on 01/01/2021.
//

import SwiftUI
import GoogleSignIn
import CryptoKit
import FirebaseAuth
import AuthenticationServices


struct SignInView: View {
    //Access to userObject that holds Google data
    @ObservedObject var user: AppDelegate
    //The uid of the apple account
    @State var appleUser: User
    
    @State var currentNonce: String?
    @State var pulse = false
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            if !user.uid.isEmpty || !self.appleUser.uid.isEmpty {
                BookTabView(user: self.user, appleUser: $appleUser)
            }
            else {
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
                            .frame(width: 260, height: 45, alignment: .center)
                            .cornerRadius(8)
                        
                    }.padding(.bottom, 20)
                }
            }
        }
        .onAppear {
            GIDSignIn.sharedInstance().restorePreviousSignIn()
        }
    }
    
    //Apple Button
    func AppleSignInButton() -> SignInWithAppleButton {
        return SignInWithAppleButton(
            onRequest: { request in
                let nonce = self.randomNonceString()
                self.currentNonce = nonce
                request.requestedScopes = [.fullName, .email]
                request.nonce = self.sha256(nonce)
            },
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    switch authResults.credential {
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        
                        guard let nonce = self.currentNonce else {
                            fatalError("Invalid state: A login callback was received, but no login request was sent.")
                        }
                        guard let appleIDToken = appleIDCredential.identityToken else {
                            fatalError("Invalid state: A login callback was received, but no login request was sent.")
                        }
                        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                            return
                        }
                        
                        let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                        
                        Auth.auth().signIn(with: credential) { (user, err) in
                            if err != nil {
                                print((err?.localizedDescription)!)
                                return
                            }
                            
                            if let user = user {
//                                self.uid = Auth.auth().currentUser?.uid ?? ""
                                self.appleUser = User(uid: user.user.uid, email: user.user.email, displayName: user.user.displayName)
                            }
                            
                        }
                    default:
                        break
                    }
                default:
                    break
                }
            }
        )
    }
    
    //Apple Auth Code
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    //Hashing function using CryptoKit
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
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
                    .frame(width: 20, height: 20)
                Text("Sign in with Google")
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .font(.system(size: 17, weight: .semibold))
            }
        })
        .frame(width: 260, height: 45, alignment: .center)
        .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
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
                    .frame(width: 20, height: 20)
                Text("Sign in with Facebook")
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .font(.system(size: 17, weight: .semibold))
            }
        })
        .frame(width: 260, height: 45, alignment: .center)
        .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
        .cornerRadius(8)
    }
}


//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView()
//    }
//}
