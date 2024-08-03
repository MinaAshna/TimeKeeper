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
    @Query(sort: \Event.endDate) var events: [Event]
    @State var isPresentingNewEventView = false
    @State private var isPresentingEditView = false
    @State private var editingEvent: Event?

    var body: some View {
        NavigationStack {
            List(events) { event in
                if event.endDate > .now {
                    Button {
                    } label: {
                        EventCardView(event: event)
                            .tint(.appText)
                    }
                    .tint(.black)
                    .buttonStyle(.borderless)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .swipeActions {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            delete(event: event)
                        }
                        Button("Edit", systemImage: "pencil", role: .none) {
                            isPresentingEditView = true
                            editingEvent = event
                            let _ = print(editingEvent?.title)
                        }
                        .tint(Color.appGreen)
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.appGray)
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isPresentingNewEventView = true
                    } label: {
                        Image(systemName: "plus")
                            .tint(.primary)
                            .bold()
                    }
                    .tint(.black)
                    .padding()
                }
            }
        }
        .onChange(of: isPresentingEditView) {
            // this is necessary to force the swiftui reevaluating the view with the updated value for editingEvent
            print(editingEvent ?? "EditingEvent is nil")
        }
        .sheet(isPresented: $isPresentingNewEventView) {
            EventView(event: nil)
        }
        .sheet(isPresented: $isPresentingEditView) {
            EventView(event: editingEvent)
        }
    }
    
    func delete(event: Event) {
        modelContext.delete(event)
        do {
            try modelContext.save()
        } catch {
            print(error)
        }
    }
}

#Preview {
    return TimeKeeperView()
        .modelContainer(DataController.previewContainer)
}

