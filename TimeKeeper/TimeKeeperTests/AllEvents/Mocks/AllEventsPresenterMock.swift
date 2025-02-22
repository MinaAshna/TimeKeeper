import UIKit
@testable import TimeKeeper

@MainActor
class AllEventsPresenterMock {
    var events: [Event] = []
    var isFailedToFetchEvents = false
}

extension AllEventsPresenterMock: AllEventsPresenterProtocol {
    
    func listOfEvents(events: [TimeKeeper.Event]) {
        self.events = events
    }
    
    func failedToFetchEvents() {
        isFailedToFetchEvents = true
    }
}
