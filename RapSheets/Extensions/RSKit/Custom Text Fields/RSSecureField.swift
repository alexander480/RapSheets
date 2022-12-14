//
//  RSSecureField.swift
//  RapSheets
//
//  Created by Alexander Lester on 9/27/22.
//

import SwiftUI

struct RSSecureField: View {
    
    let placeholder: String
    @Binding var text: String

    var body: some View {
        SecureField(placeholder, text: $text)
            .foregroundColor(.black)
            .font(Font.custom("Futura", size: 14).weight(.regular))
            .padding(EdgeInsets(top: 13, leading: 21, bottom: 15, trailing: 10))
            .frame(width: 277, height: 50)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.black, lineWidth: 3)
                        .overlay(
                            Text(placeholder)
                                .foregroundColor(.black)
                                .padding([.leading, .trailing], 6)
                                .background(Rectangle().fill(Color.white))
                                .font(Font.custom("Futura", size: 12).weight(.semibold))
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                .offset(x: 16, y: 5.5)
                        )
                }
            }
   }
}

struct RSSecureField_Previews: PreviewProvider {
    static var previews: some View {
        RSSecureField(placeholder: "Password", text: .constant(""))
    }
}
