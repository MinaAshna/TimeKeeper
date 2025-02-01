//
//  AllEventsProtocol.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 01/02/2025.
//

import Foundation

@MainActor
protocol AllEventsProtocol: AnyObject {
    func listOfEvents(events: [Event])
}
