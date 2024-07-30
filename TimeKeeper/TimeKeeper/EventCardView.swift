//
//  ListRow.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 24/07/2024.
//


import SwiftUI
import SwiftData

struct EventCardView: View {
    var event: Event
    @State private var offset: Offset = Offset()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let emoji = event.emoji {
                    Text(emoji)
                }
                Text(event.title)
                    .foregroundStyle(Color.appText)
            }
            .font(.title3)
            .bold()
            
            Divider()
            
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        if offset.year > 0 {
                            HStack(spacing: 2) {
                                Text(offset.year.description)
                                    .font(.title3)
                                    .bold()
                                Text("y")
                                    .font(.headline)
                                    .foregroundStyle(Color.appTextSecondary)
                            }
                        }
                        if offset.month > 0 {
                            HStack(spacing: 2) {
                                Text(offset.month.description)
                                    .font(.title3)
                                    .bold()
                                Text("m")
                                    .font(.headline)
                                    .foregroundStyle(Color.appTextSecondary)
                            }
                        }
                        if offset.day > 0 {
                            HStack(spacing: 2) {
                                Text(offset.day.description)
                                    .font(.title3)
                                    .bold()
                                Text("d")
                                    .font(.headline)
                                    .foregroundStyle(Color.appTextSecondary)
                            }
                        }
                        if offset.hour > 0 {
                            HStack(spacing: 2) {
                                Text(offset.hour.description)
                                    .font(.title3)
                                    .bold()
                                Text("h")
                                    .font(.headline)
                                    .foregroundStyle(Color.appTextSecondary)
                            }
                        }
                        if offset.minute > 0 {
                            HStack(spacing: 2) {
                                Text(offset.minute.description)
                                    .font(.title3)
                                    .bold()
                                Text("m")
                                    .font(.headline)
                                    .foregroundStyle(Color.appTextSecondary)
                            }
                        }
                        
                        HStack(spacing: 2) {
                            Text(offset.second.description)
                                .font(.title3)
                                .bold()
                                .contentTransition(.numericText(countsDown: true))
                            Text("s")
                                .font(.headline)
                                .foregroundStyle(Color.appTextSecondary)
                        }
                    }
                    .multilineTextAlignment(.leading)
                    .frame(maxHeight: .infinity)
                                       
                    Gauge(
                        value: totalSeconds() - secondsLeft(),
                        in: 0...totalSeconds(),
                        label: {
                            
                        },
                        currentValueLabel: {
                        }
                        
                    )
                    .tint(Color.appGreen)
    //                .gaugeStyle(.accessoryCircularCapacity)
                    
                
                    HStack {
                        Spacer()
                        Text(event.endDate, style: .date)
                            .foregroundStyle(Color.appText)
                    }
                    

                }
                
            
            }
            .padding([.top, .bottom], 8)
            .foregroundStyle(Color.appText)
            
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 1)
                .opacity(0.2)
                .shadow(color: .black, radius: 2)
            
        )
        .background(Color.appWhite)
        .cornerRadius(8) /// make the background rounded
        .onReceive(timer) { _ in
            countdown()
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
        EventCardView(event: .sampleEvents[0])
    }
}

