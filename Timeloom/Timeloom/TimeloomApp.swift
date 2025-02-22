//
//  TimeloomApp.swift
//  Timeloom
//
//  Created by Mina Ashna on 22/02/2025.
//

import SwiftUI

@main
struct TimeloomApp: App {
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
