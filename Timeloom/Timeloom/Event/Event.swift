//
//  Event.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import Foundation
import OSLog
import SwiftUI
import SwiftData

@DebugDescription
@Model
final class Event: CustomDebugStringConvertible {
    // Technically, the properties must be either optional or have a default value as it is requirement for iCloud sync. Otherwise, I wouldn't want the default values.
    // Also, another problem is that iCloud does not support unique constraints/attributes.
    /*@Attribute(.unique) */var id: UUID = UUID()
    var title: String = "No title"
    var emoji: String?
    var creationDate: Date = Date.now
    var endDate: Date = Date.now
    
    var debugDescription: String {
        "# Event title: \(title), End date: \(endDate)"
    }
    
    init(title: String, emoji: String? = "", creationDate: Date = Date.now, endDate: Date) {
        self.id = UUID()
        self.title = title
        self.emoji = emoji
        self.creationDate = creationDate
        self.endDate = endDate
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

