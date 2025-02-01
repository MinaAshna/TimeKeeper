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
    let viewModel: AllEventsViewModel
    let presenter: AllEventsPresenter
    
    init() {
        viewModel = AllEventsViewModel()
        presenter = AllEventsPresenter(viewModel: viewModel)
    }

    var body: some Scene {
        WindowGroup {
            AllEventsView(viewModel: viewModel, eventHandler: presenter)
        }
    }
}
