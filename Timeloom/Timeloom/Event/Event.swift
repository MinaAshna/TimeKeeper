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
    @Attribute(.unique) var id: UUID
    var title: String
    var emoji: String?
    var creationDate: Date = Date.now
    var endDate: Date
    
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

#if DEBUG
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
#endif

