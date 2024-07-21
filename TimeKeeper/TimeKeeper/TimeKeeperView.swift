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
            ScrollView {
                LazyVGrid(columns: [.init(.adaptive(minimum: 300))]) {
                    ForEach(events, id:\.id) { event in
                        HStack {
                            NavigationLink(destination: EventDetailView(event: event)) {
                                EventCardView(event: event)
                            }
                            .tint(.appText)
                        }
                    }
                }
                .padding([.leading, .trailing], 8)
            }
          
        

//            List(events) { event in
//                NavigationLink(destination: EventDetailView(event: event)) {
//                    EventCardView(event: event)
//                        .padding()
//                }
//                .tint(.black)
//                .swipeActions {
//                    Button("Delete", systemImage: "trash", role: .destructive) {
//                        modelContext.delete(event)
//                    }
//                }
//            }
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
    return TimeKeeperView()
        .modelContainer(DataController.previewContainer)
}

