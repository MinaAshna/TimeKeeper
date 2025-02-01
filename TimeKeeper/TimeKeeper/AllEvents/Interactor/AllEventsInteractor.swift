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
    weak var allEventsProtocol: (any AllEventsProtocol)?
    
    init(dataManager: DataManagerProtocol, allEventsProtocol: (any AllEventsProtocol)? = nil) {
        self.dataManager = dataManager
        self.allEventsProtocol = allEventsProtocol
    }
}

extension AllEventsInteractor: AllEventsInteractorProtocol {
    func readAllEvents() {
        let events = dataManager.readAllEvents()
        allEventsProtocol?.listOfEvents(events: events)
    }
    
    func delete(event: Event) {
        dataManager.delete(event: event)
    }
    
    func save(event: Event) {
        dataManager.save(event: event)
    }
}
