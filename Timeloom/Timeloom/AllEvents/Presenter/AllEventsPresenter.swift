//
//  AllEventsPresenter.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 01/02/2025.
//

import Foundation
import CloudKit

@MainActor
class AllEventsPresenter {
    weak var viewModel: AllEventsViewModel?
    var interactor: (any AllEventsInteractorProtocol)?
    
    init(viewModel: AllEventsViewModel, interactor: (any AllEventsInteractorProtocol)? = nil) {
        self.viewModel = viewModel
        
        if let interactor = interactor {
            self.interactor = interactor
        } else {
            self.interactor = AllEventsInteractor(allEventsProtocol: self)
        }
    }
    
}

extension AllEventsPresenter: AllEventsPresenterEventHandler {
    func viewDidAppear() {
        readAllEvents()
    }
    
    func viewDidRefreshed() {
        readAllEvents()
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
        guard let viewModel = viewModel else { return }
        
        viewModel.ongoingEvents = viewModel.events.filter { $0.endDate > .now && $0.creationDate < .now }
        viewModel.pastEvents = viewModel.events.filter { $0.endDate < .now }
    }
}

extension AllEventsPresenter: AllEventsPresenterProtocol {
    func listOfEvents(events: [Event]) {
        guard let viewModel = viewModel else { return }

        viewModel.events = events
        clusterEvents()
    }
    
    func failedToFetchEvents() {
        // TODO: UI for error cases
    }
}

extension AllEventsPresenter {
    private func readAllEvents() {
        interactor?.readAllEvents()
    }
}
