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
                        Image(systemName: "plus")
                            .tint(.primary)
                            .bold()
                    }
                    .tint(.black)
                    .padding()
                }
            }
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Text(Date.now, style: .date)
//                    .tint(.black)
//                }
//            }
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
                                editingEvent = .emptyEvent
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

