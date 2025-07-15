//
//  ProfileViewModel.swift
//  to_do_list
//
//  Created by Khant Phone Naing  on 15/07/2025.
//

import Foundation
import UIKit

class ProfileViewModel: ObservableObject {
    @Published var name: String = "User"
    @Published var email: String = "user@gmail.com"
    @Published var phoneNumber: String = "-"
    @Published var profileImage: UIImage? = nil

    init() {
        loadProfile()
        loadProfileImage()
    }
    
    private let profileKey: String = "profile_key"
    private let imageFilename = "profile_image"
    
    func loadProfile() {
        guard
            let data = UserDefaults.standard.data(forKey: profileKey),
            let savedData = try? JSONDecoder().decode(ProfileModel.self, from: data)
        else {
            return
        }
        
        name = savedData.name
        email = savedData.email
        phoneNumber = savedData.phone_number
    }
    
    func saveProfile() {
        let profile = ProfileModel(name: name, email: email, phone_number: phoneNumber)
        
        if let encodedData = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(encodedData, forKey: profileKey)
        }
    }
    
    func loadProfileImage(_ image: UIImage) {
        self.profileImage = image
        if let data = image.pngData() {
            let url = getDocumentsDirectory().appendingPathComponent(imageFilename)
            try? data.write(to: url)
        }
    }
    
    func loadProfileImage() {
        let url = getDocumentsDirectory().appendingPathComponent(imageFilename)
        if let data = try? Data(contentsOf: url),
           let image = UIImage(data: data)
        {
            self.profileImage = image
        }
    }
    
    func saveProfileImage(_ image: UIImage) {
            self.profileImage = image
            if let data = image.pngData() {
                let url = getDocumentsDirectory().appendingPathComponent(imageFilename)
                try? data.write(to: url)
            }
        }
    
    private func getDocumentsDirectory() -> URL {
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        }
}
