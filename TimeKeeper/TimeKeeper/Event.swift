//
//  Event.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class Event: Identifiable {
    @Attribute(.unique) let id: UUID = UUID()
    var title: String
    var creationDate: Date = Date.now
    var endDate: Date
    
    init(title: String, creationDate: Date = Date.now, endDate: Date) {
        self.title = title
        self.creationDate = creationDate
        self.endDate = endDate
    }
}

extension Event {
    nonisolated(unsafe) static let emptyEvent: Event = Event(title: "", endDate: .now)
    
#if DEBUG
    @Transient nonisolated(unsafe) static let sampleEvents: [Event] = [Event(title: "Event1",
                                                         creationDate:Calendar.current.date(byAdding: .month, value: -1, to: Date.init())!,
                                                         endDate: Calendar.current.date(byAdding: .month, value: 1, to: Date.init())!),
                                                   Event(title: "Event2",
                                                         endDate: Calendar.current.date(byAdding: .day, value: 1, to: Date.init())!)]
    #endif
}

