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
                ForEach(events, id:\.id) { event in
                    HStack {
                        
                        NavigationLink(destination: EventDetailView(event: event)) {
                            EventCardView(event: event)
                        }
                        .tint(.black)
                        
                        Spacer()
                    }
                    .padding([.leading, .trailing], 20)
                    .padding(.bottom, 10)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
            }
        

//            List(events) { event in
//                NavigationLink(event.title,
//                               destination: EventDetailView(event: event))
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

