//
//  DataManager.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 01/02/2025.
//

import Foundation
import OSLog
import SwiftData


class DataManager {
    private let context: ModelContext
    
    init(container: ModelContainer) {
        self.context = ModelContext(container)
    }
}

extension DataManager: DataManagerProtocol {
    func delete(event: Event) {
        context.delete(event)
        saveContext()
    }
    
    func save(event: Event) {
        context.insert(event)
        saveContext()
    }
    
    func readAllEvents() throws -> [Event] {
//        let ongoingEvents = #Predicate<Event> {
//            $0.endDate < Date() &&
//        }
        let descriptor = FetchDescriptor<Event>(sortBy: [SortDescriptor(\Event.creationDate, order: .reverse)]/*, predicate: ongoingEvents*/)
        do {
            return try context.fetch(descriptor)
        } catch {
            Logger.data.error("Failed to fetch events: \(error.localizedDescription)")
            throw AppError.dataManagerFetchError(error.localizedDescription)
        }
    }
}

extension DataManager {
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
