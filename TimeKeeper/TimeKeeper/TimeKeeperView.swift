//
//  ContentView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import SwiftUI
import SwiftData

struct TimeKeeperView: View {
    @Environment(\.modelContext) var modelContext
    @Query var events: [Event]
    @State var isPresentingNewEventView = false
    
    var body: some View {
        NavigationStack {
            List(events) { event in
                NavigationLink(event.title,
                               destination: EventDetailView(event: event))
            }
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isPresentingNewEventView = true
                    } label: {
                        Image(systemName: "hourglass.badge.plus")
                            .tint(.primary)
                    }
                    .tint(.black)
                    .padding()
                }
            }
        }
        .sheet(isPresented: $isPresentingNewEventView) {
            NewEventView(isPresentingNewEventView: $isPresentingNewEventView)
        }
    }
}

#Preview {
    TimeKeeperView()
}

