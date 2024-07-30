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
    @State private var newEvent = Event.emptyEvent
    @State private var isPresentingEditView = false
    @State private var editingIndex: IndexSet = .init()
    
    init() {
        print("init")
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(events) { event in
                    Button {
                    } label: {
                        EventCardView(event: event)
                            .tint(.appText)
                    }
                    .tint(.black)
                    .buttonStyle(.borderless)
                    .swipeActions {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            modelContext.delete(event)
                            do {
                                try modelContext.save()
                            } catch {
                                print(error)
                            }
                        }
                        Button("Edit", systemImage: "pencil", role: .none) {
                            isPresentingEditView = true
                            editingEvent = event
                        }
                        .tint(Color.appGreen)
                    }
                    .listRowSeparatorTint(Color.appGray, edges: .all)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.appGray)
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        newEvent = .emptyEvent
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
                EventView(event: $newEvent)
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
                                modelContext.insert(newEvent)
                                do {
                                    try modelContext.save()
                                } catch {
                                    print(error)
                                }
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
                                do {
                                    try modelContext.save()
                                } catch {
                                    print(error)
                                }
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
    
//    func deleteEvent(_ indexSet: IndexSet) {
//        for index in indexSet {
//            let event = events[index]
//            modelContext.delete(event)
//            do {
//                try modelContext.save()
//            } catch {
//                print(error)
//            }
//        }
//    }
}

#Preview {
    return TimeKeeperView()
        .modelContainer(DataController.previewContainer)
}

