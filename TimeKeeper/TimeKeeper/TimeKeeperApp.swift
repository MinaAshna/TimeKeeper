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
//    let modelContainer: ModelContainer
//       
//       init() {
//           do {
//               modelContainer = try ModelContainer(for: Event.self)
//           } catch {
//               fatalError("Could not initialize ModelContainer")
//           }
//       }
//       
       var body: some Scene {
           WindowGroup {
               TimeKeeperView()
           }
           .modelContainer(for: Event.self)
       }
}
