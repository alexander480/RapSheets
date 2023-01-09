//
//  LoginView.swift
//  RapSheets
//
//  Created by Alexander Lester on 9/20/22.
//

import SwiftUI
import FirebaseAuth


struct LoginView: View {

    @EnvironmentObject var viewRouter: ViewRouter
    // @EnvironmentObject var authState: AuthStateManager
    @EnvironmentObject var authState: AuthViewModel
    
    let theme = DefaultTheme()
    
    @State var email = ""
    @State var password = ""
    
    // --------------------
    // MARK: Views
    // --------------------
    
    fileprivate func ProfilePlaceholder() -> some View {
        Image("profile_placeholder")
            .frame(width: 120, height: 120)
            .padding([.top, .bottom], 45)
    }
    
    fileprivate func LoginForm() -> some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(.black, lineWidth: 3)
                .foregroundColor(.white)
            
            VStack(alignment: .center) {
                
                RSTextField(placeholder: "Email Address", text: $email)
                    .textContentType(.emailAddress)
                    .frame(width: 277, height: 50)
                    .padding(.bottom, 18)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                
                RSSecureField(placeholder: "Password", text: $password)
                    .textContentType(.password)
                    .frame(width: 277, height: 50)
                    .padding(.bottom, 18)
                
                Button("SIGN IN") {
                    authState.signIn(email: email, password: password) { didSignIn in
                        if (didSignIn) {
                            viewRouter.currentPage = .Dashboard
                        }
                    }
                }
                .font(Font.custom("Futura", size: 18).weight(.heavy))
                .frame(width: 277, height: 54, alignment: .center)
                .gradientForeground(colors: theme.buttonGradient)
                .gradientBorder(colors: theme.buttonGradient, cornerRadius: 12.0, lineWidth: 4.0)
            }
        }
        .frame(width: 334, height: 266)
    }
    
    fileprivate func ThirdPartyButtons() -> some View {
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
    }
    
    fileprivate func createAccountButton() -> some View {
        Button("CREATE ACCOUNT") {
            viewRouter.currentPage = .Registration
        }
        .font(Font.custom("Futura", size: 18).weight(.heavy))
        .frame(width: 277, height: 54, alignment: .center)
        .gradientForeground(colors: theme.buttonGradient)
        .gradientBorder(colors: theme.buttonGradient, cornerRadius: 12.0, lineWidth: 4.0)
        .padding()
    }
    
    fileprivate func DividerLine() -> some View {
        RoundedRectangle(cornerRadius: 2).frame(width: 250, height: 3).padding(8)
    }
    
    // --------------------
    // MARK: Body
    // --------------------
    
    var body: some View {
        
        VStack() {
            
            self.ProfilePlaceholder()
            
            self.DividerLine()
            
            self.LoginForm()
            
            // self.DivderLine()
            // self.ThirdPartyButtons()
            
            self.DividerLine()
            
            // Display Error Message If Login Failed
            if let errorMessage = authState.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(Font.custom("Futura", size: 13).weight(.regular))
                    .multilineTextAlignment(.center)
                    .frame(width: 334)
                    .padding()
            }
            
            Spacer()
            
            self.createAccountButton()
        }
        .onAppear(perform: {
            if authState.isLoggedIn {
                viewRouter.currentPage = .Dashboard
            }
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
