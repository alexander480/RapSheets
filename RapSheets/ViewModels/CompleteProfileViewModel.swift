//
//  CompleteProfileViewModel.swift
//  RapSheets
//
//  Created by Alexander Lester on 11/21/22.
//

import SwiftUI
import UIKit
import ALExt
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class CompleteProfileViewModel: ObservableObject {
    @Published var uid: String?
    @Published var profile: Profile?
    
    @Published var isBusy = false
    @Published var errorMessage: String?
    
    fileprivate func fetchUID() -> String? {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("[ERROR] Failed To Fetch UID For Current User.")
            return nil
        }
        
        return uid
    }
    
    // MARK: -- Read Functions
    func fetchProfile(completion: @escaping () -> Void) {
        self.isBusy = true
        
        guard let uid = self.fetchUID() else {
            self.isBusy = false
            self.errorMessage = "Failed To Authorize User."
            return
        }
        
        let profileReference = Database.database().reference(withPath: "/Profiles/\(uid)/")
        profileReference.observe(.value) { snapshot, error in
            
            guard var json = snapshot.value as? [String: Any] else {
                print("[ERROR] Failed To Convert Profile Snapshot Into JSON.")
                self.isBusy = false
                self.errorMessage = "Failed To Fetch Profile."
                return
            }
            
            json["id"] = snapshot.key
            
            do {
                let decoder = JSONDecoder()
                let profileData = try JSONSerialization.data(withJSONObject: json)
                let profile = try decoder.decode(Profile.self, from: profileData)
                
                print("[SUCCESS] Successfully Created Profile Object.")
                print("[PROFILE] \(profile)")
                
                self.isBusy = false
                self.profile = profile
                
                completion()
                
            } catch {
                print("[ERROR] Failed To Decode JSON Into Profile Object. [MESSAGE] \(error)")
                self.isBusy = false
                self.errorMessage = "Failed To Fetch Profile."
            }
        }
    }
    
    // MARK: -- Update Functions
    
    func updateBasicInfo(_ basicInfo: BasicInfo, completion: @escaping (Bool) -> Void) {
        self.isBusy = true
        
        guard let uid = self.fetchUID() else {
            self.isBusy = false
            self.errorMessage = "Failed To Authorize User."
            completion(false)
            return
        }
        
        let profileReference = Database.database().reference(withPath: "/Profiles/\(uid)/")
        profileReference.child("basicInfo").setValue(basicInfo) { err, ref in
            if let error = err {
                print("[ERROR] Failed To Update Profile Info. [MESSAGE] \(error.localizedDescription)")
                self.isBusy = false
                self.errorMessage = error.localizedDescription
                completion(false)
                return
            }
            else {
                print("[SUCCESS] Successfully Updated Profile Info.")
                self.isBusy = false
                completion(true)
            }
        }
    }
    
    func updateSocialAccounts(_ socialAccounts: SocialAccounts) {
        self.isBusy = true
        
        guard let uid = self.fetchUID() else {
            self.isBusy = false
            self.errorMessage = "Failed To Authorize User."
            return
        }
        
        let profileReference = Database.database().reference(withPath: "/Profiles/\(uid)/")
        profileReference.child("accounts/socialAccounts").setValue(socialAccounts) { err, ref in
            if let error = err {
                print("[ERROR] Failed To Update Social Accounts. [MESSAGE] \(error.localizedDescription)")
                self.isBusy = false
                self.errorMessage = error.localizedDescription
                return
            }
            else {
                print("[SUCCESS] Successfully Updated Social Accounts.")
                self.isBusy = false
            }
        }
    }
    
    func updateMediaAccounts(_ mediaAccounts: MediaAccounts) {
        self.isBusy = true
        
        guard let uid = self.fetchUID() else {
            self.isBusy = false
            self.errorMessage = "Failed To Authorize User."
            return
        }
        
        let profileReference = Database.database().reference(withPath: "/Profiles/\(uid)/")
        profileReference.child("accounts/mediaAccounts").setValue(mediaAccounts) { err, ref in
            if let error = err {
                print("[ERROR] Failed To Update Media Accounts. [MESSAGE] \(error.localizedDescription)")
                self.isBusy = false
                self.errorMessage = error.localizedDescription
                return
            }
            else {
                print("[SUCCESS] Successfully Updated Media Accounts.")
                self.isBusy = false
            }
        }
    }
    
    func updateProfilePicture(image: UIImage, completion: @escaping () -> Void) {
        self.isBusy = true
        
        guard let uid = self.fetchUID() else {
            print("[ERROR] Failed To Validate Current User.")
            self.isBusy = false
            self.errorMessage = "Failed To Authorize User."
            return
        }
        
        let storageReference = Storage.storage().reference().child("Images/ProfilePictures/\(uid).jpeg")
        let databaseReference = Database.database().reference().child("Profiles/\(uid)/basicInfo/profilePictureURL")
        
        // Resize, Compress & Convert To JPEG Data
        let resizedImage = image.aspectFittedToHeight(400)
        let imageData = resizedImage.jpegData(compressionQuality: 0.25)
        
        // Create Metadata For Image
        let imageMetadata = StorageMetadata()
            imageMetadata.contentType = "image/jpg"
        
        // Validate Image Data
        guard let imageData = imageData else {
            print("[ERROR] Failed To Validate Image Data.")
            self.isBusy = false
            self.errorMessage = "Failed To Validate Profile Picture."
            return
        }
        
        // Upload Image
        storageReference.putData(imageData, metadata: imageMetadata) { (metadata, error) in
            if let metadata = metadata {
                print("[INFO] Successfully Uploaded Profile Picture. [METADATA] \(metadata)")
                
                // Get Download URL
                storageReference.downloadURL { imageURL, error in
                    if let imageURL = imageURL {
                        print("[INFO] Successfully Got URL For Uploaded Profile Picture.")
                        
                        // Update User's Profile Picture URL
                        let imageURLStr = String(describing: imageURL)
                        databaseReference.setValue(imageURLStr) { error, reference in
                            if let error = error {
                                print("[ERROR] Failed To Update Profile Picture URL. [MESSAGE] \(error)")
                                self.isBusy = false
                                self.errorMessage = error.localizedDescription
                                return
                            }
                            else {
                                print("[SUCCESS] Successfully Updated Profile Picture.")
                                self.isBusy = false
                            }
                        }
                        
                    } else if let error = error {
                        print("[ERROR] Failed To Get URL For Profile Picture. [MESSAGE] \(error)")
                        self.isBusy = false
                        self.errorMessage = error.localizedDescription
                        return
                    }
                }
                
            } else if let error = error {
                print("[ERROR] Failed To Update Profile Picture. [MESSAGE] \(error)")
                self.isBusy = false
                self.errorMessage = error.localizedDescription
                return
            }
        }
    }
}
