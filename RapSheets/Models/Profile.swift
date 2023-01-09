//
//  CompleteProfileModel.swift
//  RapSheets
//
//  Created by Alexander Lester on 11/21/22.
//

import Foundation
import FirebaseDatabase

struct ProfileData: Identifiable, Codable {
    var id: String
    var profile: Profile
}

struct Profile: Codable {
    
    var id: String
    var email: String
    
    var basicInfo: BasicInfo?
    var accounts: Accounts?
}

struct BasicInfo: Codable {
    var name: String?
    var location: String?
    var bio: String?
    
    var title: String?
    var genre: String?
    
    var profilePictureURL: String?
}

struct Accounts: Codable {
    var socialAccounts: SocialAccounts?
    var mediaAccounts: SocialAccounts?
}

struct SocialAccounts: Codable {
    var facebookName: String?
    var instagramName: String?
}

struct MediaAccounts: Codable {
    var spotifyName: String?
    var soundcloudName: String?
}

