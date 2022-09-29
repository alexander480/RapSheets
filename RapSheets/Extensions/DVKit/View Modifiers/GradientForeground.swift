import SwiftUI

struct GradientForeground: ViewModifier {
    var colors: [Color]
    
    var startPoint: UnitPoint = .leading
    var endPoint: UnitPoint = .trailing
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(
                .linearGradient(
                    colors: colors,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
}

extension View {
    func gradientForeground(colors: [Color], startPoint: UnitPoint = .leading, endPoint: UnitPoint = .trailing) -> some View {
        modifier(GradientForeground(colors: colors, startPoint: startPoint, endPoint: endPoint))
    }
}
