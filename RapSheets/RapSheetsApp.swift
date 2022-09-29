//
//  RapSheetsApp.swift
//  RapSheets
//
//  Created by Alexander Lester on 9/19/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct RapSheetsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var authState = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ApplicationSwitcher()
            }
            .navigationViewStyle(.stack)
            .environmentObject(authState)
        }
    }
}

struct ApplicationSwitcher: View {

    @EnvironmentObject var authState: AuthStateViewModel

    var body: some View {
        if (authState.isLoggedIn) {
            DashboardView()
        } else {
            LoginView()
        }
    }
}
