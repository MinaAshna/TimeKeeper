//
//  EventCardView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 06/07/2024.
//

import SwiftUI
import SwiftData

struct EventCardView: View {
    var event: Event
    @State private var offset: Offset = Offset()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(alignment: .leading) {

            Text(event.title)
                .padding(.bottom, 12)
            
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
                
                VStack {
                    Text("Second")
                        .foregroundStyle(Color.gray)
                    Text(offset.second.description)
                        .font(.headline)
                        .contentTransition(.numericText(countsDown: true))
                }
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .cornerRadius(20) /// make the background rounded
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 1)
                .opacity(0.2)
                .shadow(color: .gray, radius: 1)
        )
        
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
}

#Preview {
    NavigationStack {
        EventCardView(event: .sampleEvents[0])
    }
}
