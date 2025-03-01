//
//  EventPresenterTests.swift
//  TimeloomTests
//
//  Created by Mina Ashna on 01/03/2025.
//

import Foundation
import Testing
@testable import Timeloom

struct EventPresenterTests {

    @Test(
        .disabled("Currently broken - It's using a dynamic date rather than a static one"),
        .tags(.presentationLogic)
    )
    func calculateDiff() async throws {
        let event = Event(title: "new event",
                          emoji: "❤️",
                          creationDate: Calendar.current.date(byAdding: .month, value: -1, to: Date.init())!,
                          endDate: Calendar.current.date(byAdding: .month, value: 1, to: Date.init())!)
        let viewModel = EventViewModel(event: event)
        let sut = EventPresenter(viewModel: viewModel)
        
        sut.countdown()
        
        #expect(viewModel.offset.year == 0)
        #expect(viewModel.offset.month == 0)
        #expect(viewModel.offset.day == 30) // It can't be tested like this as the date is dynamic

    }

}
