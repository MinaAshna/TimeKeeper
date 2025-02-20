//
//  AllEventsInteractorTests.swift
//  TimeKeeperTests
//
//  Created by Mina Ashna on 20/02/2025.
//

import Testing
@testable import TimeKeeper
import Foundation

@MainActor
struct AllEventsInteractorTests {
    var presenter: AllEventsPresenterMock
    var dataManager: DataManagerMock
    var sut: AllEventsInteractor
    
    init() {
        self.presenter = AllEventsPresenterMock()
        self.dataManager = DataManagerMock()
        sut = AllEventsInteractor(dataManager: dataManager, allEventsProtocol: presenter)
    }
    
    @Test(
        "Read all events successfully",
            .tags(.CRUD)
    )
    func readAllEvents() async throws {
        dataManager.events = Event.sampleEvents
        
        sut.readAllEvents()
        
        let dataManagerFirstEvent = try #require(dataManager.events.first)
        let presenterFirstEvent = try #require(presenter.events.first)
        
        print(dataManagerFirstEvent.title, presenterFirstEvent.title)
        print(dataManagerFirstEvent.creationDate, presenterFirstEvent.creationDate)
        print(dataManagerFirstEvent.endDate, presenterFirstEvent.endDate)
        
        #expect(dataManagerFirstEvent.title == presenterFirstEvent.title)
        #expect(dataManagerFirstEvent.emoji == presenterFirstEvent.emoji)
        #expect(dataManagerFirstEvent.creationDate == presenterFirstEvent.creationDate)
        #expect(dataManagerFirstEvent.endDate == presenterFirstEvent.endDate)
        
    }
    
    @Test(
        "Failed to delete an events",
        .tags(.CRUD)
    )
    func deleteEvent() async throws {
        dataManager.events = Event.sampleEvents

        try #require(dataManager.events.count == 2)
        
        let event = try #require(dataManager.events.first)
        sut.delete(event: event)
        
        #expect(dataManager.events.count == 1)
        #expect(dataManager.events.contains(where: { $0.id == event.id }) == false)
    }
    
    
    @Test(
        "delete event and read all events",
        .tags(.CRUD)
    )
    func deleteAndReadEvents() async throws {
        dataManager.events = Event.sampleEvents

        try #require(dataManager.events.count == 2)
        
        let event = try #require(dataManager.events.first)
        sut.delete(event: event)
        sut.readAllEvents()
        
        #expect(dataManager.events.count == 1)
        #expect(dataManager.events.contains(where: { $0.id == event.id }) == false)
        #expect(dataManager.events.count == presenter.events.count)
        
        let dataManagerFirstEvent = try #require(dataManager.events.first)
        let presenterFirstEvent = try #require(presenter.events.first)
        #expect(dataManagerFirstEvent.title == presenterFirstEvent.title)
        #expect(dataManagerFirstEvent.emoji == presenterFirstEvent.emoji)
        #expect(dataManagerFirstEvent.creationDate == presenterFirstEvent.creationDate)
        #expect(dataManagerFirstEvent.endDate == presenterFirstEvent.endDate)
    }
    
    @Test(
        "Successfully save an event",
        .tags(.CRUD)
        )
    func saveEvent() async throws {
        dataManager.events = Event.sampleEvents

        try #require(dataManager.events.count == 2)
        let event = Event(title: "new event",
                          emoji: "❤️",
                          creationDate: Calendar.current.date(byAdding: .month, value: -1, to: Date.init())!,
                          endDate: Calendar.current.date(byAdding: .month, value: 1, to: Date.init())!)
        sut.save(event: event)
        
        #expect(dataManager.events.count == 3)
        #expect(dataManager.events.contains(where: { $0.id == event.id }))
    }
    
    @Test(
        "Successfully save an event and read all events",
        .tags(.CRUD)
        )
    func saveEventReadEvents() async throws {
        dataManager.events = Event.sampleEvents

        try #require(dataManager.events.count == 2)
        let event = Event(title: "new event",
                          emoji: "❤️",
                          creationDate: Calendar.current.date(byAdding: .month, value: -1, to: Date.init())!,
                          endDate: Calendar.current.date(byAdding: .month, value: 1, to: Date.init())!)
        sut.save(event: event)
        sut.readAllEvents()
        
        #expect(dataManager.events.count == 3)
        #expect(dataManager.events.contains(where: { $0.id == event.id }))
        #expect(dataManager.events.count == presenter.events.count)

        
        let dataManagerLastEvent = try #require(dataManager.events.last)
        let presenterLastEvent = try #require(presenter.events.last)
        #expect(dataManagerLastEvent.title == presenterLastEvent.title)
        #expect(dataManagerLastEvent.emoji == presenterLastEvent.emoji)
        #expect(dataManagerLastEvent.creationDate == presenterLastEvent.creationDate)
        #expect(dataManagerLastEvent.endDate == presenterLastEvent.endDate)
    }
}


extension Tag {
    @Tag static var CRUD: Self
}
