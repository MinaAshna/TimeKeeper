//
//  TabBarView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 10/08/2024.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            TimeKeeperView()
                .tabItem {
                    Label("Events", systemImage: "hourglass")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
//        .tint(Color.appGreen)
    }
}

#Preview {
    TabBarView()
}
