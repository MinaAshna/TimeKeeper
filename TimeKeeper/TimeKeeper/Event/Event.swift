//
//  Event.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import Foundation
import SwiftUI
import SwiftData
import OSLog


private let logger = Logger(subsystem: "TimeKeeperData", category: "Event")

@Model
final class Event {
    @Attribute(.unique) var id: UUID
    var title: String
    var emoji: String?
    var creationDate: Date = Date.now
    var endDate: Date
    
    init(title: String, emoji: String? = "", creationDate: Date = Date.now, endDate: Date) {
        self.id = UUID()
        self.title = title
        self.emoji = emoji
        self.creationDate = creationDate
        self.endDate = endDate
        logger.notice("Event \(self.id) has been created with title: '\(self.title)'")
    }
}

extension Event {
    @MainActor static let emptyEvent: Event = Event(title: "", endDate: .now)
    
    @Transient nonisolated(unsafe) static let sampleEvents: [Event] = [Event(title: "Event1",
                                                                             emoji: "🤩",
                                                                             creationDate: Calendar.current.date(byAdding: .month, value: -1, to: Date.init())!,
                                                                             endDate: Calendar.current.date(byAdding: .month, value: 1, to: Date.init())!),
                                                                       Event(title: "Event2",
                                                                             emoji: "😊",
                                                                             endDate: Calendar.current.date(byAdding: .day, value: 1, to: Date.init())!)]
}

