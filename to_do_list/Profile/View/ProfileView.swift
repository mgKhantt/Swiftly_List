//
//  ProfileView.swift
//  to_do_list
//
//  Created by Khant Phone Naing on 15/07/2025.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State private var showImagePicker = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                // MARK: - Header
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.orange.opacity(0.8))
                        .frame(height: 280)
                        .ignoresSafeArea(edges: .top)
                    
                    VStack(spacing: 12) {
                        Button {
                            showImagePicker = true
                        } label: {
                            if let image = profileViewModel.profileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                    .shadow(radius: 4)
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.white.opacity(0.9))
                            }
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(image: Binding(
                                get: { profileViewModel.profileImage },
                                set: { newImage in
                                    if let newImage {
                                        profileViewModel.saveProfileImage(newImage)
                                    }
                                }
                            ))
                        }
                        
                        Text(profileViewModel.name)
                            .font(.title3.bold())
                            .foregroundStyle(Color(.systemBackground))
                        
                        NavigationLink(destination: EditProfileView()) {
                            HStack {
                                Image(systemName: "pencil")
                                Text("Edit Profile")
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(20)
                            .adaptiveShadow()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                // MARK: - Contact Info
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.orange)
                        Text("\(profileViewModel.phoneNumber)")
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "mail")
                            .foregroundColor(.orange)
                        Text("\(profileViewModel.email)")
                        Spacer()
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(20)
                .adaptiveShadow()
                .padding(.horizontal)
                
                Spacer(minLength: 40)
            }
            .padding(.top)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environmentObject(ProfileViewModel())
    }
}
