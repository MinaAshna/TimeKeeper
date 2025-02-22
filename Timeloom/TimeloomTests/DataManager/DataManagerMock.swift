import UIKit
@testable import Timeloom

class DataManagerMock {
    var events: [Event] = []
}

extension DataManagerMock: DataManagerProtocol {
    func delete(event: Timeloom.Event) {
        events.removeAll(where: { $0.id == event.id })
    }
    
    func save(event: Timeloom.Event) {
        events.append(event)
    }
    
    func readAllEvents() throws -> [Timeloom.Event] {
        return events
    }
}
