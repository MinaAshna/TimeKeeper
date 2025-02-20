//
//  AllEventsEventHandler.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 01/02/2025.
//

import Foundation

@MainActor
protocol AllEventsPresenterEventHandler {
    func viewDidAppear()
    func deleteEventTapped(event: Event)
    func saveEventTapped(event: Event)
    func clusterEvents()
}
