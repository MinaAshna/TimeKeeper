import UIKit
@testable import Timeloom

@MainActor
class AllEventsPresenterMock {
    var events: [Event] = []
    var isFailedToFetchEvents = false
}

extension AllEventsPresenterMock: AllEventsPresenterProtocol {
    
    func listOfEvents(events: [Timeloom.Event]) {
        self.events = events
    }
    
    func failedToFetchEvents() {
        isFailedToFetchEvents = true
    }
}
