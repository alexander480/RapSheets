//
//  UserStateViewModel.swift
//  RapSheets
//
//  Created by Alexander Lester on 9/29/22.
//

import Foundation
import FirebaseAuth

enum AuthStateError: Error {
    case signInError
    case signOutError
}

@MainActor class AuthStateViewModel: ObservableObject {

    @Published var isLoggedIn = false
    @Published var isBusy = false
    
    @Published var errorMessage: String?

    func signIn(email: String, password: String) async -> Result<Bool, AuthStateError >  {
        isBusy = true
        
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            self.isLoggedIn = true
            self.isBusy = false
            
            return .success(true)
        }
        catch {
            self.errorMessage = error.localizedDescription
            self.isBusy = false
            
            return .failure(.signInError)
        }
    }

    func signOut() async -> Result<Bool, AuthStateError>  {
        self.isBusy = true
        
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            isBusy = false
            
            return .success(true)
        }
        catch {
            isBusy = false
            errorMessage = error.localizedDescription
            
            return .failure(.signOutError)
        }
    }
}

