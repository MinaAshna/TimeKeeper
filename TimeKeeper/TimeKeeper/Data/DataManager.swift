//
//  DataManager.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 01/02/2025.
//

import Foundation
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
    
    func readAllEvents() -> [Event] {
        let descriptor = FetchDescriptor<Event>(sortBy: [SortDescriptor(\Event.creationDate, order: .reverse)])
        return (try? context.fetch(descriptor)) ?? []
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
