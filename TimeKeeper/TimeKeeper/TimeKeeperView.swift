//
//  ContentView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import SwiftUI
import SwiftData
import MessageUI

struct TimeKeeperView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Event.endDate) var events: [Event]
    @State var isPresentingNewEventView = false
    @State private var isPresentingEditView = false
    @State private var isPresentingMailView = false
    @State private var editingEvent: Event?
    @State private var latestDate: Date = .now
    @State var result: Result<MFMailComposeResult, Error>? = nil
    
    var body: some View {
        NavigationStack {
            List(events) { event in
                if event.endDate > .now {
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
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.appGray)
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button {
                            isPresentingMailView = true
                        } label: {
                            Image(systemName: "text.bubble")
                                .tint(.primary)
                                .bold()
                        }
                        .tint(.black)
                        .padding(.trailing, 8)
                        
                        Button {
                            isPresentingNewEventView = true
                        } label: {
                            Image(systemName: "plus")
                                .tint(.primary)
                                .bold()
                        }
                        .tint(.black)
                    }
                    .padding(.trailing, 16)
                }
            }
        }
        .onAppear {
            latestDate = calculateLatestDate()
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
        .sheet(isPresented: $isPresentingMailView) {
            MailView(result: $result)
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

