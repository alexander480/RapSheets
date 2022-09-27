//
//  LoginView.swift
//  RapSheets
//
//  Created by Alexander Lester on 9/20/22.
//

import SwiftUI
import FirebaseAuth

let buttonGradient = [ Color(hex: "4000FF"), Color(hex: "b452b4") ]

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
        VStack() {
            
            // Profile Placeholder
            Group {
                Spacer()
                
                Image("profile_placeholder")
                    .frame(width: 120, height: 120)
                    .padding()
                
                Spacer()
                RoundedRectangle(cornerRadius: 2).frame(width: 250, height: 3).padding(8)
            }
            
            // Login Form
            Group {
                ZStack() {
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(.black, lineWidth: 3)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .center) {
                        
                        RSTextField(placeholder: "Email Address", text: $email)
                            .frame(width: 277, height: 50)
                            .padding(.bottom, 18)
                        
                        RSSecureField(placeholder: "Password", text: $password)
                            .frame(width: 277, height: 50)
                            .padding(.bottom, 18)
                            
                        Button("SIGN IN") { login() }
                            .font(Font.custom("Futura", size: 18).weight(.heavy))
                            .frame(width: 277, height: 54, alignment: .center)
                            .gradientForeground(colors: buttonGradient)
                            .gradientBorder(colors: buttonGradient, cornerRadius: 12.0, lineWidth: 4.0)
                    }
                }
                .frame(width: 331, height: 266)
            }
            
            RoundedRectangle(cornerRadius: 2).frame(width: 250, height: 3).padding(8)
            
            // SSO View
            Group {
                ZStack() {
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(.black, lineWidth: 3)
                        .foregroundColor(.white)
                        
                    
                    HStack(alignment: .center) {
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Image("apple_icon")
                                .frame(width: 46, height: 46)
                        }
                        
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image("google_icon")
                                .frame(width: 46, height: 46)
                        }
                        
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image("facebook_icon")
                                .frame(width: 46, height: 46)
                        }
                        
                        Spacer()
                    }
                }
                .frame(width: 331, height: 90)
                
                RoundedRectangle(cornerRadius: 2).frame(width: 250, height: 3).padding(8)
                Spacer()
            }
            
            Group {
                
                // Create Account Button
                Button("CREATE ACCOUNT") {
                    
                }
                .font(Font.custom("Futura", size: 18).weight(.heavy))
                .frame(width: 277, height: 54, alignment: .center)
                .gradientForeground(colors: buttonGradient)
                .gradientBorder(colors: buttonGradient, cornerRadius: 12.0, lineWidth: 4.0)
                .padding()
                
//                RoundedRectangle(cornerRadius: 2)
//                    .frame(width: 250, height: 3)
//                    .padding(8)
                
            }
            
            //.padding()
            //Spacer()
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("[ERROR] Failed To Sign In. [MESSAGE] \(error.localizedDescription)")
                return
            } else {
                print("[SUCCESS] Successfully Signed In.")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
