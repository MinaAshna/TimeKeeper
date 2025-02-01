//
//  EventViewModel.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 01/02/2025.
//

import Foundation

@Observable class EventViewModel {
    var event: Event
    var offset: Offset = Offset()
    var isCountDownDone: Bool = false
    
    init(event: Event) {
        self.event = event
    }
    
    func secondsLeft() -> Double {
        if event.endDate > .now {
            let diff = event.endDate.timeIntervalSince(.now)
            return round(diff)
        } else {
            return 0
        }
    }
    
    func totalSeconds() -> Double {
        let diff = event.endDate.timeIntervalSince(event.creationDate)
        return round(diff)
    }
}
