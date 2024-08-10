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
    @State private var latestDate: Date = .now
    @State private var ongoingEvents = [Event]()
    @State private var pastEvents = [Event]()
    
    var body: some View {
        NavigationStack {
            List {
                Section("Ongoing Events") {
                    ForEach(ongoingEvents, id: \.id) { event in
                        Button {
                        } label: {
                            EventCardView(event: event, latestDate: latestDate)
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
                            }
                            .tint(Color.appGreen)
                        }
                    }
                }
                
                Section("Past Events") {
                    ForEach(pastEvents, id: \.id) { event in
                        Button {
                        } label: {
                            EventCardView(event: event, latestDate: latestDate)
                                .tint(.appText)
                        }
                        .tint(.black)
                        .buttonStyle(.borderless)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .disabled(true)
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
                    .padding(.trailing, 16)
                }
            }

//            .safeAreaInset(edge: .top) {
//                HStack {
//                    Spacer()
//                    
//                    Text(Date.now, style: .date)
//                        .padding(.trailing, 24)
//                }
//                .background(Color.appGray)
//                .controlSize(.extraLarge)
//            }
        }
        .onAppear {
            latestDate = calculateLatestDate()
            ongoingEvents = events.filter { $0.endDate > .now && $0.creationDate < .now }
            pastEvents = events.filter { $0.endDate < .now }
        }
        .onChange(of: events) {
            latestDate = calculateLatestDate()
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
    
    func calculateLatestDate() -> Date {
        let dates = events.map { $0.endDate }
        let max = dates.max() ?? .now
        print("Latest date: \(max)")
        return max
    }
}

#Preview {
    return TimeKeeperView()
        .modelContainer(DataController.previewContainer)
}
