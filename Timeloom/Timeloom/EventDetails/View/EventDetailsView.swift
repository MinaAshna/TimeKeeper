//
//  CountdownView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import SwiftUI
import SwiftData

struct EventDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var emoji: String?
    @State private var endDate: Date = .now
    @State fileprivate var errorMessage: String?
    var eventHandler: AllEventsPresenterEventHandler
    var event: Event?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Write a title for your event")
                            .font(.title3)
                            .bold()
                        TextField("Title", text: $title, axis: .vertical)
                            .padding(16)
                            .frame(height: 60)
                            .background(Color.appGray)
                            .cornerRadius(12)
                    }
                    .padding(.vertical)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("When will this event happen?")
                            .font(.title3)
                            .bold()
                        
                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundStyle(Color.red)
                        }
                        
                        DatePicker("End Date",
                                   selection: $endDate,
                                   in: Date()...)
                        .datePickerStyle(.graphical)
                    }
                    .padding(.vertical)
                    
                    Spacer()
                }
            }
            .padding()
            .onAppear {
                title = event?.title ?? ""
                emoji = event?.emoji
                endDate = event?.endDate ?? .now
            }
            .onChange(of: endDate) {
                errorMessage = nil
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        withAnimation {
                            dismiss()
                        }
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(Color.red)
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        withAnimation {
                            if save() {
                                dismiss()
                            }
                        }
                    } label: {
                        Text(event != nil ? "Done" : "Add")
                            .bold()
                            .foregroundStyle(Color.primary)
                    }
                }
            }
        }
    }
    
    private func save() -> Bool {
        guard endDate > .now else {
            errorMessage = "Date should be in the future"
            return false
        }
        
        if let event {
            event.title = title
            event.emoji = emoji
            event.endDate = endDate
        } else {
            let event = Event(title: title, emoji: emoji, endDate: endDate)
            eventHandler.saveEventTapped(event: event)
        }
        
        return true
    }
}

#Preview("Happy Path") {
    let sampleEvent = Event.sampleEvents.first!
    
    
    let viewModel = AllEventsViewModel()
    let presenter = AllEventsPresenter(viewModel: viewModel)

    
    EventDetailsView(eventHandler: presenter, event: sampleEvent)
}

#Preview("Error case") {
    let sampleEvent = Event(title: "Event1",
                            emoji: "",
                            creationDate: Calendar.current.date(byAdding: .month, value: -1, to: Date.init())!,
                            endDate: .now)
    
    
    let viewModel = AllEventsViewModel()
    let presenter = AllEventsPresenter(viewModel: viewModel)

    
    let view = EventDetailsView(eventHandler: presenter, event: sampleEvent)
    view.errorMessage = "Date should be in the future"
    
    return view
}
