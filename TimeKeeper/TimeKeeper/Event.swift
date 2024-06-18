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
    @Transient static var sampleEvents: [Event] = [Event(title: "Event1", endDate: .now),
                                                 Event(title: "Event2", endDate: .now)]
    #endif
}
