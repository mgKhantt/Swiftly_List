//
//  SettingView.swift
//  to_do_list
//
//  Created by Khant Phone Naing  on 15/07/2025.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var isAcitveTouchID: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                NavigationLink(destination: ProfileView()) {
                    HStack {
                        if let image = profileViewModel.profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                .shadow(radius: 4)
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        
                        VStack(alignment: .leading) {
                            Text("\(profileViewModel.name)")
                                .font(.headline)
                                .fontWeight(.medium)
                            Text("View Profile")
                                .font(.subheadline)
                                .foregroundStyle(.blue)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.gray)
                    }
                    .padding()
                    .background(.background)
                    .cornerRadius(10)
                    .adaptiveShadow()
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
                
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("General")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: TestView()) {
                            HStack {
                                Image(systemName: "clock.arrow.circlepath")
                                Text("My History")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        NavigationLink(destination: TestView()) {
                            HStack {
                                Image(systemName: "bonjour")
                                Text("Refer a friend")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                    }
                }
                .padding()
                .background(.background)
                .cornerRadius(10)
                .adaptiveShadow()
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Setting")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    NavigationLink(destination: TestView()) {
                        HStack {
                            Image(systemName: "globe")
                            Text("Language")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                .padding()
                .background(.background)
                .cornerRadius(10)
                .adaptiveShadow()
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Security")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    HStack {
                        Toggle(isOn: $isAcitveTouchID) {
                            HStack {
                                Image(systemName: "touchid")
                                Text("Fingerprint / Face ID")
                            }
                        }.tint(.orange)
                    }
                    
                    HStack {
                        NavigationLink(destination: TestView()) {
                            HStack {
                                Image(systemName: "lock")
                                Text("Update Pin")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                    }
                }
                .padding()
                .background(.background)
                .cornerRadius(10)
                .adaptiveShadow()
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Support")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    NavigationLink(destination: TestView()) {
                        HStack {
                            Image(systemName: "questionmark.circle")
                            Text("FAQs")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    
                    NavigationLink(destination: TestView()) {
                        HStack {
                            Image(systemName: "bubble.left.and.text.bubble.right")
                            Text("Contact Us")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    NavigationLink(destination: TestView()) {
                        HStack {
                            Image(systemName: "play.rectangle")
                            Text("Tutorials")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                .padding()
                .background(.background)
                .cornerRadius(10)
                .adaptiveShadow()
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("About App")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    NavigationLink(destination: TestView()) {
                        HStack {
                            Image(systemName: "text.document")
                            Text("Terms and Conditions")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    
                    NavigationLink(destination: TestView()) {
                        HStack {
                            Image(systemName: "swift")
                            Text("About Swiftly List")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    
                    HStack {
                        Image(systemName: "iphone.gen3")
                        Text("App Version")
                        Spacer()
                        Text("v 2.1.5")
                    }
                    
                }
                .padding()
                .background(.background)
                .cornerRadius(10)
                .adaptiveShadow()
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
                
                HStack {
                    Button(role: .destructive) {
                        print("Delete Account")
                    } label: {
                        HStack {
                            Image(systemName: "x.circle")
                            Text("Delete Account")
                        }
                    }
                    Spacer()
                }
                .padding()
                .background(.background)
                .cornerRadius(10)
                .adaptiveShadow()
                .padding(.horizontal)
                
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Log Out")
                    }
                    Spacer()
                }
                .padding()
                .background(.background)
                .cornerRadius(10)
                .adaptiveShadow()
                .padding(.horizontal)
                
                Spacer(minLength: 70)
            }
            .padding(.top, 8)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Settings")
    }
    
}

#Preview {
    NavigationStack{
        SettingView()
    }
}


struct TestView: View {
    var body: some View {
        Text("Hello, World!")
    }
}
