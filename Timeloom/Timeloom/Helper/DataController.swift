//
//  DataController.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 18/06/2024.
//

import Foundation
import SwiftData

@MainActor
class DataController {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Event.self, configurations: config)

            
            for i in 1...4 {
                let event = Event(title: "Example Event \(i)",
                                  endDate: Calendar.current.date(byAdding: .day, value: i, to: .now)!)
                container.mainContext.insert(event)
            }
            for i in 1...3 {
                let event = Event(title: "Example Event \(i)",
                                  endDate: Calendar.current.date(byAdding: .year, value: i, to: .now)!)
                container.mainContext.insert(event)
            }
            for i in 1...2 {
                let event = Event(title: "Example Event \(i)",
                                  endDate: Calendar.current.date(byAdding: .month, value: i, to: .now)!)
                container.mainContext.insert(event)
            }

            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}
