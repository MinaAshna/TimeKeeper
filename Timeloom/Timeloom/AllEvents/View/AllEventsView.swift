//
//  ContentView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import SwiftUI
import SwiftData

struct AllEventsView: View {
    var viewModel: AllEventsViewModel
    var eventHandler: AllEventsPresenterEventHandler
    
    @State private var isPresentingNewEventView = false
    @State private var isPresentingEditView = false

    
    var body: some View {
        NavigationStack {
            List {
                Section(Translations.ongoingEvents.localizedKey) {
                    ForEach(viewModel.ongoingEvents, id: \.id) { event in
                        Button {
                        } label: {
                            EventView(viewModel: EventViewModel(event: event),
                                      allEventHandler: eventHandler)
                                .tint(.appText)
                        }
                        .tint(.black)
                        .buttonStyle(.borderless)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .swipeActions {
                            Button(Translations.deleteEvent.localizedKey,
                                   systemImage: "trash",
                                   role: .destructive) {
                                eventHandler.deleteEventTapped(event: event)
                            }
                            Button(Translations.editEvent.localizedKey,
                                   systemImage: "pencil",
                                   role: .none) {
                                isPresentingEditView = true
                                viewModel.editingEvent = event
                            }
                            .tint(Color.appGreen)
                        }
                    }
                }
                
                Section(Translations.pastEvents.localizedKey) {
                    ForEach(viewModel.pastEvents, id: \.id) { event in
                        Button {
                        } label: {
                            EventView(viewModel: EventViewModel(event: event),
                                      allEventHandler: eventHandler)
                                .tint(.appText)
                        }
                        .tint(.black)
                        .buttonStyle(.borderless)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .disabled(true)
                        .swipeActions {
                            Button(Translations.deleteEvent.localizedKey,
                                   systemImage: "trash",
                                   role: .destructive) {
                                eventHandler.deleteEventTapped(event: event)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.appGray)
            .navigationTitle(Translations.allEventsNavigationTitle.localizedKey)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isPresentingNewEventView = true
                    } label: {
                        Image(systemName: "plus")
                            .tint(.primary)
                            .bold()
                    }
                    .tint(.black)
                    .padding(.trailing, 16)
                    .accessibilityLabel(Translations.accessibilityAddNewEvent.localizedKey)
                }
            }
        }
        .onAppear {
            eventHandler.viewDidAppear()
        }
        .sheet(isPresented: $isPresentingNewEventView) {
            EventDetailsView(eventHandler: eventHandler, event: nil)
        }
        .sheet(isPresented: $isPresentingEditView) {
            EventDetailsView(eventHandler: eventHandler, event: viewModel.editingEvent)
        }
    }

}

#Preview {
    // TODO: use mocks and dummys
    let viewModel = AllEventsViewModel()
    let presenter = AllEventsPresenter(viewModel: viewModel)
    
    AllEventsView(viewModel: viewModel, eventHandler: presenter)
}
