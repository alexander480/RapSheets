//
//  LineSpacer.swift
//  RapSheets
//
//  Created by Alexander Lester on 9/20/22.
//

//import SwiftUI
//
//struct LineSpacer: Shape {
//    var padding: CGFloat
//
//    var lineLength: CGFloat = 250
//    var lineWidth: CGFloat = 3
//
//    var isRounded: Bool = true
//
//    func path(in rect: CGRect) -> Path {
//        let originOffset = (rect.width - lineLength) / 2
//        let lineOrigin = CGPoint(x: (rect.origin.x + originOffset), y: padding)
//
//        let lineRect = CGRect(origin: lineOrigin, size: CGSize(width: lineLength, height: lineWidth))
//        let cornerRadius = (isRounded) ? 2.0 : 0
//
//        let linePath = Path(roundedRect: lineRect, cornerRadius: cornerRadius)
//
//        return linePath
//    }
//}
