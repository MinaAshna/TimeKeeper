//
//  AllEventsInteractor.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 01/02/2025.
//

import Foundation

@MainActor
class AllEventsInteractor {
    let dataManager: DataManagerProtocol
    weak var allEventsProtocol: (any AllEventsPresenterProtocol)?
    
    init(dataManager: DataManagerProtocol, allEventsProtocol: (any AllEventsPresenterProtocol)?) {
        self.dataManager = dataManager
        self.allEventsProtocol = allEventsProtocol
    }
}

extension AllEventsInteractor: AllEventsInteractorProtocol {
    func readAllEvents() {
        do {
            let events = try dataManager.readAllEvents()
            allEventsProtocol?.listOfEvents(events: events)
        } catch {
            allEventsProtocol?.failedToFetchEvents()
        }
    }
    
    func delete(event: Event) {
        dataManager.delete(event: event)
    }
    
    func save(event: Event) {
        dataManager.save(event: event)
    }
}
