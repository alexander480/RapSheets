//
//  CompleteProfileView.swift
//  RapSheets
//
//  Created by Alexander Lester on 11/8/22.
//

// TODO: Add Error Message Views.

import SwiftUI
import PhotosUI

struct CompleteProfileView: View {
    
    @EnvironmentObject var completeProfile: CompleteProfileViewModel
    
    let theme = DefaultTheme()
    @State var isEditable: Bool = true
    
    @State var stageName = ""
    @State var location = ""
    @State var jobTitle = ""
    @State var preferedGenre = ""
    @State var biography = ""
    
    // For Profile Picture ImagePicker
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    // @State private var profileImage = UIImage()
    // @State private var showImagePicker = false
    
    fileprivate func BannerView(title: String) -> some View {
        VStack {
            ZStack {
                Rectangle()
                    .cornerRadius(9, corners: [.topLeft, .topRight])
                    .foregroundColor(theme.buttonGradient.first!)
                    
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        Rectangle()
                            .padding(.leading, 20)
                            .padding(.trailing, 8)
                            .frame(height: 1.75)
                            .foregroundColor(.white)
                        
                        Text(title)
                            .font(Font.custom("Futura", size: 12.0).weight(.semibold))
                            .foregroundColor(.white)
                            
                        
                        Rectangle()
                            .padding(.leading, 8)
                            .padding(.trailing, 20)
                            .frame(height: 1.75)
                            .foregroundColor(.white)
                        
                    }
                    
                    Spacer()
                    
                    Rectangle().frame(height: 3)
                }
                
            }
            .frame(height: 38)
            
            Spacer()
        }
        .padding(.all, 3)
    }
    
    fileprivate func MyInfoBlock() -> some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(.black, lineWidth: 3)
                
                BannerView(title: "MY INFO")
                
                VStack {
                    
                    // MARK: -- Profile Image
                    Group {
                        Spacer().padding(.top, 18) // Extra Space
                        
                        ZStack {
                            // -- Image
                            if let profilePicStr = completeProfile.profile?.basicInfo?.profilePictureURL {
                                AsyncImage(url: URL(string: profilePicStr)) { image in
                                    image
                                        .resizable()
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(lineWidth: 4)
                                        )
                                        .frame(width: 128, height: 128)
                                    
                                } placeholder: {
                                    Image("profile_placeholder")
                                        .frame(width: 128, height: 128)
                                        //.padding(.top, 32)
                                        //.padding(.bottom, 36)
                                }
                            }
                            else {
                                Image("profile_placeholder")
                                    .frame(width: 128, height: 128)
                                    //.padding(.top, 32)
                                    //.padding(.bottom, 36)
                            }
                            
                            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                                Text("UPDATE IMAGE")
                                    .font(Font.custom("Futura", size: 12).weight(.bold))
                                    .frame(width: 125, height: 25, alignment: .center)
                                    .gradientForeground(colors: theme.buttonGradient)
                                    .gradientBorder(colors: theme.buttonGradient, cornerRadius: 8.0, lineWidth: 3.0)
                                    .background(Color.white)
                                    .padding(.top, 110)
                            }
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    // Retrieve selected asset in the form of Data
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        selectedImageData = data
                                        if let image = UIImage(data: data) {
                                            self.completeProfile.updateProfilePicture(image: image) {
                                                print("Updated Profile Picture.")
                                            }
                                        }
                                    }
                                }
                            }
                        
//                            if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
//                                Image(uiImage: uiImage)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 250, height: 250)
//                            }
                        }
                        .padding(.bottom, 15)
                    }
                    
                    // MARK: -- Text Inputs
                    Group {
                        // -- Gradient Line
                        HStack {
                            Rectangle()
                                .frame(width: 320, height: 2, alignment: .leading)
                                .padding(.bottom, 20)
                                .gradientForeground(colors: theme.buttonGradient)
                            Spacer()
                        }
                        
                        // -- Text Inputs
                        RSTextField(placeholder: "Stage Name", text: $stageName)
                            .textContentType(.nickname)
                            .frame(width: 277, height: 50)
                            .padding(.bottom, 18)
                        
                        RSTextField(placeholder: "Location", text: $location)
                            .textContentType(.location)
                            .frame(width: 277, height: 50)
                            .padding(.bottom, 18)
                        
                        RSTextField(placeholder: "Job Title", text: $jobTitle)
                            .textContentType(.jobTitle)
                            .frame(width: 277, height: 50)
                            .padding(.bottom, 18)
                        
                        RSTextField(placeholder: "Prefered Genre", text: $preferedGenre)
                            .frame(width: 277, height: 50)
                            .padding(.bottom, 20)
                        
                        // -- Gradient Line
                        HStack {
                            Spacer()
                            Rectangle()
                                .frame(width: 320, height: 2, alignment: .leading)
                                .padding(.bottom, 20)
                                .gradientForeground(colors: theme.buttonGradient)
                        }
                    }
                    
                    // MARK: -- Biography
                    Group {
                        RSTextEditor(placeholder: "Biography", text: $biography, height: 125, titlePlacement: .bottomLeading)
                            .textContentType(.emailAddress)
                            .padding(.bottom, 20)
                        
                        // -- Gradient Line
                        HStack {
                            Rectangle()
                                .frame(width: 320, height: 2, alignment: .leading)
                                .padding(.bottom, 20)
                                .gradientForeground(colors: theme.buttonGradient)
                            
                            Spacer()
                        }
                    }

                    // MARK: -- Save Button
                    Group {
                        Button("SAVE") {
                            
                            // MARK: -- Validate Input Fields & Submit
                            let basicInfo = BasicInfo(name: self.stageName, location: self.location, bio: self.biography, title: self.jobTitle, genre: self.preferedGenre)
                            self.completeProfile.updateBasicInfo(basicInfo) { didUpdate in
                                if (didUpdate) {
                                    print("[SUCCESS] Successfully Update Basic Info.")
                                }
                                else {
                                    print("[ERROR] Failed To Update Basic Info. [MESSAGE] \(String(describing: self.completeProfile.errorMessage)).")
                                }
                            }
                            
                        }
                        .font(Font.custom("Futura", size: 18).weight(.heavy))
                        .frame(width: 277, height: 54, alignment: .center)
                        .gradientForeground(colors: theme.buttonGradient)
                        .gradientBorder(colors: theme.buttonGradient, cornerRadius: 12.0, lineWidth: 4.0)
                    }
                }
                .padding([.top, .bottom], 32)
            }
            .padding()
        }
    }
    
    fileprivate func MyPortfolioButton(title: String, description: String, action: @autoclosure @escaping () -> Void) -> some View {
        HStack() {
            Spacer()
            
            ZStack(alignment: .leading) {
                
                Rectangle()
                    .border(width: 2.5, edges: [.top, .bottom, .leading], color: .black)
                    .foregroundColor(.white)
                    .frame(width: 320, height: 72)
                    .padding(.trailing, 3)
                
                ZStack() {
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(Font.custom("Futura", size: 16).weight(.semibold))
                            
                        
                        Text(description)
                            .font(Font.custom("Futura", size: 12).weight(.regular))
                    }
                    
                }
                .padding(.leading, 52)
                
                Button {
                    action()
                } label: {
                    ZStack(alignment: .center) {
                        Circle()
                            .foregroundColor(.green)
                            .overlay(Circle().stroke(lineWidth: 3).foregroundColor(.black))
                            .frame(width: 70, height: 70)
                            
                        
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(.black)
                            .fontWeight(.regular)
                            .frame(width: 30, height: 30)
                            //.scaledToFill()
                    }
                    .padding(.leading, -28)
                }

            }
        }
    }
    
    var body: some View {
        
        ScrollView(.vertical) {
            
            // MARK: -- My Info
            
            MyInfoBlock()
            
            // MARK: -- My Portfolio
            
            VStack {
                ZStack {
                    
                    // Background
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(.black, lineWidth: 3)
                    
                    // Banner
                    BannerView(title: "MY PORTFOLIO")
                    
                    // My Portfolio Block Content
                    VStack(alignment: .trailing, spacing: 24) {
                        
                        // MARK: -- Import Songs
                        self.MyPortfolioButton(title: "ADD SONGS", description: "Showcase your music.", action: {
                            print("import songs")
                        }())
                        
                        // MARK: -- Import Songs
                        self.MyPortfolioButton(title: "CHOOSE IMAGES", description: "Showcase your pictures.", action: {
                            print("choose images")
                        }())
                        
                        // MARK: -- Import Songs
                        self.MyPortfolioButton(title: "CONNECT SOCIAL", description: "Connect your accounts.", action: {
                            print("connect social")
                        }())
                    }
                    .padding([.top], 38)
                    .padding([.top, .bottom], 32)
                }
                .padding()
            }
            .onAppear(perform: {
                completeProfile.fetchProfile {
                    if let basicInfo = completeProfile.profile?.basicInfo {
                        self.stageName = basicInfo.name ?? ""
                        self.location = basicInfo.location ?? ""
                        self.jobTitle = basicInfo.title ?? ""
                        self.preferedGenre = basicInfo.genre ?? ""
                        self.biography = basicInfo.bio ?? ""
                    }
                    else {
                        print("[WARNING] No Basic Info Found.")
                    }
                }
            })
            
        }
    }
}

struct CompleteProfileView_Previews: PreviewProvider {
    static var previews: some View {
        
        let completeProfileModel = CompleteProfileViewModel()
        CompleteProfileView().environmentObject(completeProfileModel)
    }
}
