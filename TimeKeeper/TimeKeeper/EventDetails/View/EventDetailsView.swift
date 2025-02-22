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
    var eventHandler: AllEventsEventHandler
    var event: Event?
    @State private var title: String = ""
    @State private var emoji: String?
    @State private var endDate: Date = .now
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Title of your event")
                        TextField("Title", text: $title, axis: .vertical)
                            .padding(16)
                            .frame(height: 60)
                            .background(Color.appGray)
                            .cornerRadius(12)
                    }
                    .padding(.vertical)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("End Date")
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
                            save()
                            dismiss()
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
    
    private func save() {
        if let event {
            event.title = title
            event.emoji = emoji
            event.endDate = endDate
        } else {
            let event = Event(title: title, emoji: emoji, endDate: endDate)
            eventHandler.saveEventTapped(event: event)
        }
    }
}

#Preview {
    let sampleEvent = Event(title: "Event1",
                            emoji: "🤩",
                            creationDate: Calendar.current.date(byAdding: .month, value: -1, to: Date.init())!,
                            endDate: Calendar.current.date(byAdding: .month, value: 1, to: Date.init())!)
    
    
    // TODO: use mocks and dummys
//    let container = try! ModelContainer(for: Event.self)
    let viewModel = AllEventsViewModel()
//    let dataManager = DataManager(container: container)
//    let interactor = AllEventsInteractor(dataManager: dataManager)
    let presenter = AllEventsPresenter(viewModel: viewModel/*, interactor: interactor*/)

    
    EventDetailsView(eventHandler: presenter, event: sampleEvent)
}
