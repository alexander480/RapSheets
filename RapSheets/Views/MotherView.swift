//
//  MotherView.swift
//  RapSheets
//
//  Created by Alexander Lester on 10/19/22.
//

import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentPage {
        case .Login:
            LoginView()
        case .Registration:
            RegistrationView()
        case .Dashboard:
            DashboardView()
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
