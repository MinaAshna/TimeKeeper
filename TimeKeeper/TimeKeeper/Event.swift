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
    @Attribute(.unique) var id: UUID = UUID()
    var title: String
    var creationDate: Date = Date.now
    var endDate: Date
    
    init(id: UUID = UUID(), title: String, endDate: Date) {
        self.id = id
        self.title = title
        self.endDate = endDate
    }
}

extension Event {
    static var emptyEvent: Event = Event(title: "", endDate: .now)
    #if DEBUG
    @Transient static var sampleEvents: [Event] = [Event(title: "Event1",
                                                         endDate: Calendar.current.date(byAdding: .month, value: 1, to: Date.init())!),
                                                   Event(title: "Event2",
                                                         endDate: Calendar.current.date(byAdding: .day, value: 1, to: Date.init())!)]
    #endif
}
