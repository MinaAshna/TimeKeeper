//
//  ContentView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import SwiftUI

struct TimeKeeperView: View {
    @State var countdowns: [String]
    @State var showCountdownView = false

    init(countdowns: [String] = []) {
        self.countdowns = countdowns
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(countdowns, id: \.self) {
                    NavigationLink($0,
                                   destination: Text($0))
                }
            }
            .navigationTitle("Countdowns")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showCountdownView = true
                    } label: {
                        Image(systemName: "hourglass.badge.plus")
                    }
                    .tint(.black)
                    .padding()
                }
                
            }
        }
        .sheet(isPresented: $showCountdownView) {
            CountdownView(showCountdownView: $showCountdownView)            
        }
    }
}

#Preview {
    TimeKeeperView()
}

