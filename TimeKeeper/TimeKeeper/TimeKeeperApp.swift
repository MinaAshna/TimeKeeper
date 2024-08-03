//
//  TimeKeeperApp.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import SwiftUI
import SwiftData

@main
struct TimeKeeperApp: App {
    var body: some Scene {
        WindowGroup {
            TimeKeeperView()
        }
        .modelContainer(for: Event.self)
    }
}
