//
//  EventPresenter.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 01/02/2025.
//

import Foundation

class EventPresenter {
    var viewModel: EventViewModel
    
    init(viewModel: EventViewModel) {
        self.viewModel = viewModel
    }
}

extension EventPresenter: EventEventHandler {
    func countdown() {
        let diff = diff()
        
        viewModel.offset.year = diff.year ?? 0
        viewModel.offset.month = diff.month ?? 0
        viewModel.offset.day = diff.day ?? 0
        viewModel.offset.hour = diff.hour ?? 0
        viewModel.offset.minute = diff.minute ?? 0
        viewModel.offset.second = diff.second ?? 0
        
//        if viewModel.offset.year == 0, viewModel.offset.month == 0, viewModel.offset.day == 0, viewModel.offset.hour == 0, viewModel.offset.minute == 0, viewModel.offset.second == 0 {
//            viewModel.isCountDownDone = true
//        }
    }
    
}

extension EventPresenter {
    private func diff() -> DateComponents {
        let diff = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                   from: .now,
                                                   to: viewModel.event.endDate)
        return diff
    }
}
