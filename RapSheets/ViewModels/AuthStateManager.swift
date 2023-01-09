//
//  UserStateViewModel.swift
//  RapSheets
//
//  Created by Alexander Lester on 9/29/22.
//

import SwiftUI
import FirebaseAuth

final class AuthViewModel: ObservableObject {

    @Published var isLoggedIn = false
    
    @Published var isBusy = false
    @Published var errorMessage: String?
    
    var user: User? { didSet { objectWillChange.send() } }
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            self.user = user
            
            if let _ = user?.uid {
                self.isLoggedIn = true
            }
            else {
                self.isLoggedIn = false
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void)  {
        self.isBusy = true
        
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let error = err {
                print("[ERROR] Failed To Sign In. [MESSAGE] \(error.localizedDescription)")
                self.isBusy = false
                self.errorMessage = error.localizedDescription
                
                completion(false)
            }
            else if let uid = result?.user.uid {
                print("[SUCCESS] Successfully Signed In. [UID] \(uid)")
                self.isBusy = false
                self.isLoggedIn = true
                
                completion(true)
            }
        }
    }
    
    func createUser(email: String, password: String, confirmPassword: String, completion: @escaping (Bool) -> Void) {
        self.isBusy = true
        
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            print("[WARNING] Failed To Register User. Empty Text Fields.")
            self.isBusy = false
            self.errorMessage = "Please fill in all text fields."
            
            completion(false)
        }
        else if password != confirmPassword {
            print("[WARNING] Failed To Register User. Passwords do not match.")
            self.isBusy = false
            self.errorMessage = "Passwords do not match."
            
            completion(false)
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if let error = err {
                print("[ERROR] Failed To Create User. [MESSAGE] \(error.localizedDescription)")
                self.isBusy = false
                self.errorMessage = error.localizedDescription
                
                completion(false)
            }
            else if let uid = result?.user.uid {
                print("[SUCCESS] Successfully Created User. [UID] \(uid)")
                self.isBusy = false
                self.isLoggedIn = true
                
                completion(true)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch let error {
            print("[ERROR] Failed To Sign Out. \(error.localizedDescription).")
        }
    }
}

//import Foundation
//import FirebaseAuth
//
//enum AuthStateError: Error {
//    case signInError
//    case signOutError
//}
//
//@MainActor class AuthStateManager: ObservableObject {
//
//    @Published var user: User?
//    @Published var isLoggedIn = false
//    @Published var isBusy = false
//
//    @Published var errorMessage: String?
//
//    func signIn(email: String, password: String) async -> Result<Bool, AuthStateError >  {
//        isBusy = true
//
//        do {
//            try await Auth.auth().signIn(withEmail: email, password: password)
//            self.user = Auth.auth().currentUser
//            self.isLoggedIn = true
//            self.isBusy = false
//
//            return .success(true)
//        }
//        catch {
//            self.errorMessage = error.localizedDescription
//            self.isBusy = false
//
//            return .failure(.signInError)
//        }
//    }
//
//    func signOut() async -> Result<Bool, AuthStateError>  {
//        self.isBusy = true
//
//        do {
//            try Auth.auth().signOut()
//            self.user = nil
//            isLoggedIn = false
//            isBusy = false
//
//            return .success(true)
//        }
//        catch {
//            isBusy = false
//            errorMessage = error.localizedDescription
//
//            return .failure(.signOutError)
//        }
//    }
//}

