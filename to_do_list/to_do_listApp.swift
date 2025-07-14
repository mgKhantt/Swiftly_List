//
//  to_do_listApp.swift
//  to_do_list
//
//  Created by Khant Phone Naing  on 09/07/2025.
//

import SwiftUI

@main
struct to_do_listApp: App {

    @StateObject var listViewModel: ListViewModel = ListViewModel()
    @State private var showAddSheet: Bool = false

    var body: some Scene {
        WindowGroup {
            ZStack {
                // TabView with multiple tabs
                TabView {
                    NavigationStack {
                        ListView(showAddSheet: $showAddSheet)
                    }
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }

                    Text("Upcoming")
                        .tabItem {
                            Image(systemName: "calendar")
                            Text("Upcoming")
                        }

                    Text("Inbox")
                        .tabItem {
                            Image(systemName: "bubble.left")
                            Text("Inbox")
                        }

                    Text("Settings")
                        .tabItem {
                            Image(systemName: "gearshape")
                            Text("Settings")
                        }
                }
                .environmentObject(listViewModel)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showAddSheet = true
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.orange)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 4)
                        }
                        .offset(y: -30)
                        Spacer()
                    }
                }
            }
        }
    }
}
