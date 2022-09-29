//
//  NavigationExtensions.swift
//  RapSheets
//
//  Created by Alexander Lester on 9/29/22.
//

import SwiftUI

extension View {
    func navigatePush(whenTrue toggle: Binding<Bool>) -> some View {
        NavigationLink(
            destination: self,
            isActive: toggle
        ) { EmptyView() }
    }

    func navigatePush<H: Hashable>(when binding: Binding<H>,
                                   matches: H) -> some View {
        NavigationLink(
            destination: self,
            tag: matches,
            selection: Binding<H?>(binding)
        ) { EmptyView() }
    }

    func navigatePush<H: Hashable>(when binding: Binding<H?>,
                                   matches: H) -> some View {
        NavigationLink(
            destination: self,
            tag: matches,
            selection: binding
        ) { EmptyView() }
    }
}
