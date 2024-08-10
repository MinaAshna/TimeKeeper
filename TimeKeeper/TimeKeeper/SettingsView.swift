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
                Section("Contact Me") {
                    Button {
                        isPresentingMailView = true
                    } label: {
                        Image(systemName: "text.bubble")
                            .tint(.primary)
                            .bold()
                    }
                    .tint(.black)
                    .padding(.trailing, 8)
                    .sheet(isPresented: $isPresentingMailView) {
                        MailView(result: $result)
                    }
                }
                
                Section("About Me") {
                    
                }
                
                Section("Privacy Policy") {
                    
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
