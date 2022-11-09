//
//  BorderOverlay.swift
//  RapSheets
//
//  Created by Alexander Lester on 9/27/22.
//

import SwiftUI

struct BorderOverlay: ViewModifier {
    var color: Color = .black
    var lineWidth: CGFloat = 2
    var cornerRadius: CGFloat = 0
    var corners: UIRectCorner = .allCorners
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .stroke(color, lineWidth: lineWidth)
                    .cornerRadius(cornerRadius, corners: corners)
            )
    }
}

extension View {
    func borderOverlay(color: Color = .black, lineWidth: CGFloat = 2, cornerRadius: CGFloat = 0, corners: UIRectCorner = .allCorners) -> some View {
        modifier(BorderOverlay(color: color, lineWidth: lineWidth, cornerRadius: cornerRadius, corners: corners))
    }
}

