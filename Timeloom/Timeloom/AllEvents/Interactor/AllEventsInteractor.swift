//
//  AllEventsInteractor.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 01/02/2025.
//

import Foundation
import SwiftData

@MainActor
class AllEventsInteractor {
    let dataManager: DataManagerProtocol?
    weak var allEventsProtocol: (any AllEventsPresenterProtocol)?
    
    init(dataManager: DataManagerProtocol? = nil, allEventsProtocol: (any AllEventsPresenterProtocol)?) {
        self.allEventsProtocol = allEventsProtocol
        
        if let dataManager = dataManager {
            self.dataManager = dataManager
        } else {
            let schema = Schema([Event.self])
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false,
                cloudKitDatabase: .automatic  // This enables CloudKit sync
            )
            do {
                let container = try ModelContainer(for: schema, configurations: modelConfiguration)
                self.dataManager = DataManager(container: container)
            } catch {
                // TODO: error handling
                self.dataManager = nil
                print("Failed to create DataManager: \(error)")
            }
        }
    }
}

extension AllEventsInteractor: AllEventsInteractorProtocol {
    func readAllEvents() {
        guard let dataManager = dataManager else { return }

        do {
            let events = try dataManager.readAllEvents()
            allEventsProtocol?.listOfEvents(events: events)
        } catch {
            allEventsProtocol?.failedToFetchEvents()
        }
    }
    
    func delete(event: Event) {
        guard let dataManager = dataManager else { return }

        dataManager.delete(event: event)
    }
    
    func save(event: Event) {
        guard let dataManager = dataManager else { return }

        dataManager.save(event: event)
    }
}
