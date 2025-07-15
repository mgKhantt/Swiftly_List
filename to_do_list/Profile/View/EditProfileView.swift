//
//  EditProfileView.swift
//  to_do_list
//
//  Created by Khant Phone Naing  on 15/07/2025.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Group {
                CustomInputField(title: "Full Name *", text: $fullName)
                CustomInputField(title: "Email Address", text: $email)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Mobile Number *")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    TextField("", text: $phoneNumber)
                        .disabled(true)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(15)
                }
            }

            Spacer()
            
            Button(action: {
                profileViewModel.name = fullName
                profileViewModel.email = email
                profileViewModel.phoneNumber = phoneNumber
                profileViewModel.saveProfile()
                dismiss()
            }) {
                Text("Save")
                    .foregroundColor(Color(.systemBackground))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(30)
            }
            .padding(.bottom, 20)
        }
        .padding()
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            fullName = profileViewModel.name
            email = profileViewModel.email
            phoneNumber = profileViewModel.phoneNumber
        }
        .padding(.bottom, 25)
    }
}

// Custom TextField with label and orange stroke
struct CustomInputField: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.footnote)
                .foregroundColor(.gray)
            
            TextField("", text: $text)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.orange, lineWidth: 1))
        }
    }
}

#Preview {
    NavigationStack {
        EditProfileView()
            .environmentObject(ProfileViewModel())
    }
}
