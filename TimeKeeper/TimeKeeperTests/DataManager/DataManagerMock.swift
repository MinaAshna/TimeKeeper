import UIKit
@testable import TimeKeeper

class DataManagerMock {
    var events: [Event] = []
}

extension DataManagerMock: DataManagerProtocol {
    func delete(event: TimeKeeper.Event) {
        events.removeAll(where: { $0.id == event.id })
    }
    
    func save(event: TimeKeeper.Event) {
        events.append(event)
    }
    
    func readAllEvents() throws -> [TimeKeeper.Event] {
        return events
    }
}
