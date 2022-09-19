import SwiftUI

struct GradientBorder: ViewModifier {
    var colors: [Color]
    
    var startPoint: UnitPoint = .leading
    var endPoint: UnitPoint = .trailing
    
    var lineWidth: CGFloat
    var cornerRadius: CGFloat = 0.0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(LinearGradient(colors: colors, startPoint: startPoint, endPoint: endPoint), lineWidth: lineWidth)
            )
    }
}

extension View {
    func gradientBorder(colors: [Color], startPoint: UnitPoint = .leading, endPoint: UnitPoint = .trailing, cornerRadius: CGFloat, lineWidth: CGFloat) -> some View {
        modifier(GradientBorder(colors: colors, startPoint: startPoint, endPoint: endPoint, lineWidth: lineWidth, cornerRadius: cornerRadius))
    }
}
