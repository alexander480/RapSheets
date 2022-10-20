//
//  BasicRegistrationView.swift
//  RapSheets
//
//  Created by Alexander Lester on 10/11/22.
//

import SwiftUI
import FirebaseAuth

struct RegistrationView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    let theme = DefaultTheme()
    
    @State var isProcessing = false
    @State var errorMessage = ""
    
    // @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    
    let buttonGradient = [ Color(hex: "4000FF"), Color(hex: "b452b4") ]
    
    fileprivate func DividerLine() -> some View {
        RoundedRectangle(cornerRadius: 8).frame(width: 250, height: 3).padding(8)
    }
    
    var body: some View {
        VStack {
            
            DividerLine()
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(.black, lineWidth: 4)
                    .foregroundColor(.white)
                    .frame(width: 334, height: 535)
                
                VStack {
                    ZStack {
                        Image("profile_placeholder")
                            .frame(width: 120, height: 120)
                            .padding(.top, 32)
                            .padding(.bottom, 36)
                        
                        Button("CHOOSE IMAGE") {
                            
                        }
                        .font(Font.custom("Futura", size: 12).weight(.bold))
                        .frame(width: 125, height: 25, alignment: .center)
                        .gradientForeground(colors: theme.buttonGradient)
                        .gradientBorder(colors: theme.buttonGradient, cornerRadius: 8.0, lineWidth: 3.0)
                        .background(Color.white)
                        .padding(.top, 110)
                    }

                    
//                    RSTextField(placeholder: "Full Name", text: $name)
//                        .textContentType(.emailAddress)
//                        .frame(width: 277, height: 50)
//                        .padding(.bottom, 18)
                    
                    RSTextField(placeholder: "Email Address", text: $email)
                        .textContentType(.emailAddress)
                        .frame(width: 277, height: 50)
                        .padding(.bottom, 18)
                    
                    RSSecureField(placeholder: "Password", text: $password)
                        .textContentType(.password)
                        .frame(width: 277, height: 50)
                        .padding(.bottom, 18)
                    
                    RSSecureField(placeholder: "Confirm Password", text: $confirmPassword)
                        .textContentType(.password)
                        .frame(width: 277, height: 50)
                        .padding(.bottom, 32)
                    
                    Button("CREATE ACCOUNT") {
                        self.createUser(email: email, password: password, confirmPassword: confirmPassword)
                    }
                    .font(Font.custom("Futura", size: 18).weight(.heavy))
                    .frame(width: 277, height: 54, alignment: .center)
                    .gradientForeground(colors: theme.buttonGradient)
                    .gradientBorder(colors: theme.buttonGradient, cornerRadius: 12.0, lineWidth: 4.0)
                    .padding(.bottom, 32)
                    
                    if (self.isProcessing) {
                        ProgressView()
                    }
                    
                    if (!self.errorMessage.isEmpty) {
                        Text("Failed To Create Account. " + self.errorMessage)
                            .multilineTextAlignment(.center)
                            .font(Font.footnote)
                            .foregroundColor(.red)
                            .padding(.top, -32)
                            .frame(height: 25)
                            .padding([.leading, .trailing, .bottom])
                    }
                }
            }
            
            DividerLine()
        }
    }
    
    fileprivate func createUser(email: String, password: String, confirmPassword: String) {
        self.isProcessing = true
        
        // Validate Inputs
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            print("[WARNING] Failed To Register User. Empty Text Fields.")
            self.isProcessing = false
            self.errorMessage = "Please fill in all text fields."
            return
        }
        else if password != confirmPassword {
            print("[WARNING] Failed To Register User. Passwords do not match.")
            self.isProcessing = false
            self.errorMessage = "Passwords do not match."
            return
        }
        
        // Create Account
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else {
                self.isProcessing = false
                self.errorMessage = error!.localizedDescription
                return
            }
            
            switch result {
                case .none:
                    print("[WARNING] Failed To Register User.")
                    self.isProcessing = false
                    
                case .some(_):
                    print("[SUCCESS] Successfully Registered User.")
                    self.isProcessing = false
                    viewRouter.currentPage = .Dashboard
            }
            
        }
    }
    
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
