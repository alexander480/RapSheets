//
//  MotherView.swift
//  RapSheets
//
//  Created by Alexander Lester on 10/19/22.
//

import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject private var authModel: AuthViewModel
    
    var body: some View {
        
        VStack() {
            Text("MotherView")
                .hidden()
        }.onAppear(perform: authModel.listenToAuthState)
        
        // Only Allow Unauthorized Navigation To Auth Screens
        if authModel.isLoggedIn == true {
            
            // Navigate To Current Page
            switch viewRouter.currentPage {
                case .Login:
                    LoginView()
                case .Registration:
                    RegistrationView()
                case .Dashboard:
                    DashboardView()
                case .CompleteProfile:
                    CompleteProfileView().environmentObject(CompleteProfileViewModel())
            }
            
        }
        else {
            LoginView()
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
