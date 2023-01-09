//
//  DashboardView.swift
//  RapSheets
//
//  Created by Alexander Lester on 9/29/22.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button("Complete Profile") {
            viewRouter.currentPage = .CompleteProfile
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
