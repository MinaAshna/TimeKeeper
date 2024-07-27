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
    @State private var editingEvent = Event.emptyEvent
    @State private var isPresentingEditView = false
    
    var body: some View {
        NavigationStack {
            List(events) { event in
                    Button {
                    } label: {
                        EventCardView(event: event)
                            .tint(.appText)
                    }
                    .tint(.black)
                    .buttonStyle(.borderless)
                    .swipeActions {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            
                        }
                        Button("Edit", systemImage: "pencil", role: .none) {
                            editingEvent = event
                            isPresentingEditView = true
                        }
                        .tint(Color.appGreen)
                    }
                    .listRowSeparatorTint(Color.appGray, edges: .all)
                    .listRowBackground(Color.clear) // Change Row Color
                    .listRowSeparator(.hidden) //hide Seprator
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.appGray)
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        editingEvent = .emptyEvent
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
            NavigationStack {
                EventView(event: $editingEvent)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                isPresentingNewEventView = false
                            } label: {
                                Text("Cancel")
                                    .foregroundStyle(Color.red)
                            }
                        }
                        
                        ToolbarItem(placement: .confirmationAction) {
                            Button {
                                isPresentingNewEventView = false
                            } label: {
                                Text("Done")
                                    .bold()
                                    .foregroundStyle(Color.primary)
                            }
                        }
                    }
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                EventView(event: $editingEvent)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                isPresentingEditView = false
                            } label: {
                                Text("Cancel")
                                    .foregroundStyle(Color.red)
                            }
                        }
                        
                        ToolbarItem(placement: .confirmationAction) {
                            Button {
                                isPresentingEditView = false
                                events.first(where: { $0.id == editingEvent.id } )?.title = editingEvent.title
                                events.first(where: { $0.id == editingEvent.id } )?.endDate = editingEvent.endDate
                            } label: {
                                Text("Done")
                                    .bold()
                                    .foregroundStyle(Color.primary)
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    return TimeKeeperView()
        .modelContainer(DataController.previewContainer)
}

