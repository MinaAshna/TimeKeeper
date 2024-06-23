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
                .font(.title)
            
            Spacer()
            
//            Text(String(format: "%02d:%02d:%02d:%02d:%02d:%02d", offset.year, offset.month, offset.day, offset.hour, offset.minute, offset.second))
//                .contentTransition(.numericText(countsDown: true))
      
            
            VStack(spacing: 0) {
                HStack {
                    Text(event.creationDate, style: .date)
                    Spacer()
                    Text(event.endDate, style: .date)
                }
                .padding()
                
                Gauge(
                    value: totalSeconds() - secondsLeft(),
                    in: 0...totalSeconds(),
                    label: { },
                    currentValueLabel: {
                        HStack {
                            if offset.year > 0 {
                                VStack {
                                    Text("Year")
                                        .foregroundStyle(Color.gray)
                                    Text(offset.year.description)
                                        .font(.headline)
                                }
                            }
                            if offset.month > 0 {
                                VStack {
                                    Text("Month")
                                        .foregroundStyle(Color.gray)
                                    Text(offset.month.description)
                                        .font(.headline)
                                }
                            }
                            if offset.day > 0 {
                                VStack {
                                    Text("Day")
                                        .foregroundStyle(Color.gray)
                                    Text(offset.day.description)
                                        .font(.headline)
                                }
                            }
                            if offset.hour > 0 {
                                VStack {
                                    Text("Hour")
                                        .foregroundStyle(Color.gray)
                                    Text(offset.hour.description)
                                        .font(.headline)
                                }
                            }
                            if offset.minute > 0 {
                                VStack {
                                    Text("Minute")
                                        .foregroundStyle(Color.gray)
                                    Text(offset.minute.description)
                                        .font(.headline)
                                }
                            }
                            if offset.second > 0 {
                                VStack {
                                    Text("Second")
                                        .foregroundStyle(Color.gray)
                                    Text(offset.second.description)
                                        .font(.headline)
                                        .contentTransition(.numericText(countsDown: true))
                                }
                            }
                        }
                        .padding()
                    }
                )
                .padding()
            }
            
            Spacer()
        }
        .onReceive(timer) { _ in
            countdown()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isPresentingEditView = true
                    editingEvent = event
                } label: {
                    Text("Edit")
                }
            }
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
    
    func secondsLeft() -> Double {
        let diff = event.endDate.timeIntervalSince(.now)
        return round(diff)
    }
    func totalSeconds() -> Double {
        let diff = event.endDate.timeIntervalSince(event.creationDate)
        return round(diff)
    }
}

#Preview {
    NavigationStack {
        EventDetailView(event: Event.sampleEvents[0])
    }
}
