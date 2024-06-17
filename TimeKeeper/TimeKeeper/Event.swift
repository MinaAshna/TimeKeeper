//
//  Event.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import Foundation
import SwiftUI

//@Observable
struct Event: Identifiable {
    var id: UUID = UUID()
    var title: String
    var endDate: Date
//    var timeLeft: Date {
//        calculateTheTimeLeft()
//    }
    static var emptyEvent: Event = Event(title: "", endDate: .now)
    #if DEBUG
    static var sampleEvents: [Event] = [Event(title: "Event1", endDate: .now),
                                                 Event(title: "Event2", endDate: .now)]
    #endif
    
//    init(id: UUID = UUID(), title: String, endDate: Date) {
//        self.id = id
//        self.title = title
//        self.endDate = endDate
//    }
    
//    
//    func calculateTheTimeLeft() -> Date {
//        return Date()
//    }
}
