//
//  AllSetView.swift
//  RapSheets
//
//  Created by Alexander Lester on 11/6/22.
//

import SwiftUI

struct AlmostDoneView: View {
    
    let theme = DefaultTheme()
    
    var body: some View {
        
        VStack {
            
            // MARK: Top Section
            
            Spacer()
            
            Image("profile_placeholder_gradient_border")
                .padding(.bottom, 8)
            
            Text("ALMOST DONE")
                .font(Font.custom("Futura", size: 28).weight(.heavy))
                .padding(.bottom, 0.1)
            
            Text("Complete your profile to start connecting with other artists and showcasing your work.")
                .font(Font.custom("Futura", size: 13).weight(.regular))
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing, .bottom], 50)
            
            Spacer()
            
            // MARK: Bottom Section
            
            Group {
                Button("COMPLETE PROFILE") {
                    
                }
                .font(Font.custom("Futura", size: 20).weight(.heavy))
                .frame(width: 340, height: 55)
                .gradientForeground(colors: theme.buttonGradient)
                .gradientBorder(colors: theme.buttonGradient, cornerRadius: 12.0, lineWidth: 4.0)
                .background(Color.white)
                .padding([.leading, .trailing], 12)
                .padding(.bottom, 8)
                
                Button(action: {
                    
                }) {
                    Text("Complete Later")
                        .font(Font.custom("Futura", size: 14.0).weight(.regular).italic())
                        .foregroundColor(.black)
                        .underline()
                        .padding(.bottom, 12)
                }
            }
        }
    }
}

struct AlmostDoneView_Previews: PreviewProvider {
    static var previews: some View {
        AlmostDoneView()
    }
}
