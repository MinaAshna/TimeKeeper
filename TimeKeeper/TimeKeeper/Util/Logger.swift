//
//  Logger.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 02/02/2025.
//

import OSLog

@MainActor
extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs everyrthing related to events.
    static let events = Logger(subsystem: subsystem, category: "events")
    
    /// Logs the data manager events related to Swift Data.
    static let data = Logger(subsystem: subsystem, category: "data")
    
    
    /// All logs related to tracking and analytics.
//    static let statistics = Logger(subsystem: subsystem, category: "statistics")
}
