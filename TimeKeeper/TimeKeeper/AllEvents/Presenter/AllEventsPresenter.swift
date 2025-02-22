//
//  AllEventsPresenter.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 01/02/2025.
//

import Foundation
import SwiftData

@MainActor
class AllEventsPresenter {
    var viewModel: AllEventsViewModel
    var interactor: (any AllEventsInteractorProtocol)?
    
    init(viewModel: AllEventsViewModel) {
        self.viewModel = viewModel
        
        do {
            let container = try ModelContainer(for: Event.self)
            let dataManager = DataManager(container: container)
            let interactor = AllEventsInteractor(dataManager: dataManager, allEventsProtocol: self)
            self.interactor = interactor
        } catch {
            // TODO: Error handling
            print(error)
        }
    }
    
}

extension AllEventsPresenter: AllEventsPresenterEventHandler {
    func viewDidAppear() {
        interactor?.readAllEvents()
    }
    
    func deleteEventTapped(event: Event) {
        interactor?.delete(event: event)
        interactor?.readAllEvents()
    }
    
    func saveEventTapped(event: Event) {
        interactor?.save(event: event)
        interactor?.readAllEvents()
    }
    
    func clusterEvents() {
        viewModel.ongoingEvents = viewModel.events.filter { $0.endDate > .now && $0.creationDate < .now }
        viewModel.pastEvents = viewModel.events.filter { $0.endDate < .now }
    }
}

extension AllEventsPresenter: AllEventsPresenterProtocol {
    func listOfEvents(events: [Event]) {
        viewModel.events = events
        clusterEvents()
    }
    
    func failedToFetchEvents() {
        // TODO: UI for error cases
    }
}
