//
//  SettingsView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 10/08/2024.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State private var isPresentingMailView = false

    var body: some View {
        NavigationStack {
            List {
                Button {
                    isPresentingMailView = true
                } label: {
                    Label("Email", systemImage: "text.bubble")
                }
                .sheet(isPresented: $isPresentingMailView) {
                    MailView(result: $result)
                }
                
                NavigationLink {
                    Text("About")
                } label: {
                    Label("About", systemImage: "info.square")
                }
                
            }
            .tint(Color.appText)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
