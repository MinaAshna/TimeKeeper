//
//  AllEventsViewModel.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 01/02/2025.
//

import Foundation

@MainActor
@Observable class AllEventsViewModel {
    var events: [Event] = []
    var ongoingEvents = [Event]()
    var pastEvents = [Event]()
    var editingEvent: Event?
}
