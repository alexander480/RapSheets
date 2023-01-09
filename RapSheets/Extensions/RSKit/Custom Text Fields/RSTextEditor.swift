//
//  RSTextEditor.swift
//  RapSheets
//
//  Created by Alexander Lester on 11/18/22.
//

import SwiftUI

struct RSTextEditor: View {
    
    let placeholder: String
    @Binding var text: String
    
    @State var height: CGFloat = 200
    @State var isEditable: Bool = true
    @State var titlePlacement: Alignment = .bottomLeading
    
    @State private var titleBorderPlacement: Edge = .bottom
    @State private var titleOffset: (CGFloat, CGFloat) = (16, 5.5)
    
    var body: some View {
        
        TextEditor(text: $text)
            .foregroundColor(.black)
            .font(Font.custom("Futura", size: 14).weight(.regular))
            .padding(EdgeInsets(top: 13, leading: 21, bottom: 15, trailing: 10))
            .frame(width: 277, height: self.height)
            .disabled(!self.isEditable)
            .background {
                ZStack {
                    if (self.isEditable) {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.black, lineWidth: 3)
                            .overlay(
                                Text(placeholder)
                                    .foregroundColor(.black)
                                    .padding([.leading, .trailing], 6)
                                    .background(Rectangle().fill(Color.white))
                                    .font(Font.custom("Futura", size: 12).weight(.semibold))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: self.titlePlacement)
                                    .offset(x: self.titleOffset.0, y: self.titleOffset.1)
                            )
                    }
                    else {
                        Rectangle()
                            .foregroundColor(.white)
                            .border(width: 3, edges: [self.titleBorderPlacement], color: .black)
                            .overlay(
                                Text(placeholder)
                                    .foregroundColor(.black)
                                    .padding([.leading, .trailing], 6)
                                    .background(Rectangle().fill(Color.white))
                                    .font(Font.custom("Futura", size: 12).weight(.semibold))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: self.titlePlacement)
                                    .offset(x: self.titleOffset.0, y: self.titleOffset.1)
                            )
                        
                    }
                    
                }
            }
            .onAppear(perform: {
                switch self.titlePlacement {
                    case .topLeading:
                        self.titleOffset = (16, -5.5)
                        self.titleBorderPlacement = .top
                    case .topTrailing:
                        self.titleOffset = (-16, -5.5)
                        self.titleBorderPlacement = .top
                    case .bottomLeading:
                        self.titleOffset = (16, 5.5)
                        self.titleBorderPlacement = .bottom
                    case .bottomTrailing:
                        self.titleOffset = (-16, 5.5)
                        self.titleBorderPlacement = .bottom
                    default:
                        self.titleOffset = (-16, 5.5)
                        self.titleBorderPlacement = .bottom
                }
            })
    }
}


struct RSTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        RSTextEditor(placeholder: "Biography", text: .constant("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."))
    }
}
