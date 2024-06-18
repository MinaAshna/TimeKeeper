//
//  EventDetailView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import SwiftUI

struct EventDetailView: View {
    var event: Event
    @State private var editingEvent = Event.emptyEvent
    @State private var isPresentingEditView = false
    @State private var offset: Offset = Offset()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text(event.title)
            
            Text(String(format: "%02d:%02d:%02d:%02d:%02d:%02d", offset.year, offset.month, offset.day, offset.hour, offset.minute, offset.second))
                .contentTransition(.numericText(countsDown: true))

            
//            Text(offset.year + offset.month + offset.day + offset.hour + offset.minute + offset.second, style: .timer)
//                .contentTransition(.numericText(countsDown: true))
            
            
            Button {
                isPresentingEditView = true
                editingEvent = event
            } label: {
                Text("Edit")
            }
        }
        .onReceive(timer) { _ in
            countdown()
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                EventView(event: $editingEvent)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                isPresentingEditView = false
                            } label: {
                                Text("Cancel")
                                    .foregroundStyle(Color.red)
                            }
                        }
                        
                        ToolbarItem(placement: .confirmationAction) {
                            Button {
                                isPresentingEditView = false
                                event.title = editingEvent.title
                                event.endDate = editingEvent.endDate
                            } label: {
                                Text("Done")
                                    .bold()
                                    .foregroundStyle(Color.primary)
                            }
                        }
                    }
            }
        }
    }

    func diff() -> DateComponents {
        let diff = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: .now, to: event.endDate)
        return diff
    }
    
    func countdown() {
        let diff = diff()
        
        offset.year = diff.year ?? 0
        offset.month = diff.month ?? 0
        offset.day = diff.day ?? 0
        offset.hour = diff.hour ?? 0
        offset.minute = diff.minute ?? 0
        offset.second = diff.second ?? 0
    }
}

#Preview {
    EventDetailView(event: Event.sampleEvents[0])
}
