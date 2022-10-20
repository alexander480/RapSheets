//
//  RapSheetsApp.swift
//  RapSheets
//
//  Created by Alexander Lester on 9/19/22.
//

import SwiftUI
import FirebaseCore

@main
struct RapSheetsApp: App {
    @StateObject var viewRouter = ViewRouter()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MotherView().environmentObject(viewRouter)
        }
    }
}

//struct ApplicationSwitcher: View {
//
//    @EnvironmentObject var authState: AuthStateViewModel
//
//    var body: some View {
//        if (authState.isLoggedIn) {
//            DashboardView()
//        } else {
//            LoginView()
//        }
//    }
//}
