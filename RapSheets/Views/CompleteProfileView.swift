//
//  CompleteProfileView.swift
//  RapSheets
//
//  Created by Alexander Lester on 11/8/22.
//

import SwiftUI

struct CompleteProfileView: View {
    
    let theme = DefaultTheme()
    
    @State var email = ""
    
    fileprivate func bannerView(title: String) -> some View {
        VStack {
            ZStack {
                Rectangle()
                    .cornerRadius(9, corners: [.topLeft, .topRight])
                    .foregroundColor(theme.buttonGradient.first!)
                    
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        Rectangle()
                            .padding(.leading, 20)
                            .padding(.trailing, 8)
                            .frame(height: 1.75)
                            .foregroundColor(.white)
                        
                        Text(title)
                            .font(Font.custom("Futura", size: 12.0).weight(.semibold))
                            .foregroundColor(.white)
                            
                        
                        Rectangle()
                            .padding(.leading, 8)
                            .padding(.trailing, 20)
                            .frame(height: 1.75)
                            .foregroundColor(.white)
                        
                    }
                    
                    Spacer()
                    
                    Rectangle().frame(height: 3)
                }
                
            }
            .frame(height: 38)
            
            Spacer()
        }
        .padding(.all, 3)
    }
    
    var body: some View {
        
        ScrollView(.vertical) {
            
            // MARK: -- My Info
            
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(.black, lineWidth: 3)
                    
                    bannerView(title: "MY INFO")
                    
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
                        
                        // MARK: -- Gradient Line
                        HStack {
                            Rectangle()
                                .frame(width: 280, height: 2, alignment: .leading)
                                .padding(.bottom, 30)
                                .gradientForeground(colors: theme.buttonGradient)
                            
                            Spacer()
                        }
                        
                        RSTextField(placeholder: "Email Address", text: $email)
                            .textContentType(.emailAddress)
                            .frame(width: 277, height: 50)
                            .padding(.bottom, 18)
                        
                        RSTextField(placeholder: "Email Address", text: $email)
                            .textContentType(.emailAddress)
                            .frame(width: 277, height: 50)
                            .padding(.bottom, 18)
                        
                        RSTextField(placeholder: "Email Address", text: $email)
                            .textContentType(.emailAddress)
                            .frame(width: 277, height: 50)
                            .padding(.bottom, 18)
                        
                        RSTextField(placeholder: "Email Address", text: $email)
                            .textContentType(.emailAddress)
                            .frame(width: 277, height: 50)
                            .padding(.bottom, 18)
                        
                        // MARK: -- Gradient Line
                        HStack {
                            Spacer()
                            
                            Rectangle()
                                .frame(width: 280, height: 2, alignment: .leading)
                                .padding(.bottom, 30)
                                .gradientForeground(colors: theme.buttonGradient)
                        }
                        
                        
                    }
                    .padding([.top, .bottom], 32)
                }
                .padding()
            }
            //.frame(height: 600)
            
            // MARK: -- My Portfolio
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(.black, lineWidth: 3)
                
                bannerView(title: "MY PORTFOLIO")
            }
            .frame(height: 300)
            .padding([.leading, .trailing])
            .padding(.top, -12)
        }
        
    }
}

struct CompleteProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteProfileView()
    }
}
