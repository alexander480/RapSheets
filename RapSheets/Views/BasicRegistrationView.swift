//
//  BasicRegistrationView.swift
//  RapSheets
//
//  Created by Alexander Lester on 10/11/22.
//

import SwiftUI

struct BasicRegistrationView: View {
    
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    
    let buttonGradient = [ Color(hex: "4000FF"), Color(hex: "b452b4") ]
    
    fileprivate func DividerLine() -> some View {
        RoundedRectangle(cornerRadius: 2).frame(width: 250, height: 3).padding(8)
    }
    
    var body: some View {
        VStack {
            
            ZStack() {
                
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(.black, lineWidth: 4)
                    .foregroundColor(.white)
                
                VStack(alignment: .center) {
                    
                    ZStack {
                        Image("profile_placeholder")
                            .frame(width: 120, height: 120)
                            .padding(.top, 36)
                            .padding(.bottom, 36)
                        
                        Button("CHOOSE IMAGE") {
                            
                        }
                        .font(Font.custom("Futura", size: 12).weight(.bold))
                        .frame(width: 125, height: 25, alignment: .center)
                        .gradientForeground(colors: buttonGradient)
                        .gradientBorder(colors: buttonGradient, cornerRadius: 8.0, lineWidth: 3.0)
                        .background(Color.white)
                        .padding(.top, 110)
                    }

                    
                    RSTextField(placeholder: "Full Name", text: $name)
                        .textContentType(.emailAddress)
                        .frame(width: 277, height: 50)
                        .padding(.bottom, 18)
                    
                    RSSecureField(placeholder: "Email Address", text: $email)
                        .textContentType(.password)
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

                    }
                    .font(Font.custom("Futura", size: 18).weight(.heavy))
                    .frame(width: 277, height: 54, alignment: .center)
                    .gradientForeground(colors: buttonGradient)
                    .gradientBorder(colors: buttonGradient, cornerRadius: 12.0, lineWidth: 4.0)
                    .padding(.bottom, 32)
                    
                }
            }
            .frame(width: 334, height: 420)
        }
    }
}

struct BasicRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        BasicRegistrationView()
    }
}
