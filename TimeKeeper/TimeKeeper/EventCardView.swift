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
    let columns = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 8,
                           maximum: UIScreen.main.bounds.width / 4))
        ]

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
            
            HStack {
                
                if offset.year > 0 {
                    HStack(spacing: 2) {
                        Text(offset.year.description)
                            .font(.title3)
                            .bold()
                        Text("y")
                            .font(.headline)
                            .foregroundStyle(Color.gray)
                    }
                }
                if offset.month > 0 {
                    HStack(spacing: 2) {
                        Text(offset.month.description)
                            .font(.title3)
                            .bold()
                        Text("m")
                            .font(.headline)
                            .foregroundStyle(Color.gray)
                    }
                }
                if offset.day > 0 {
                    HStack(spacing: 2) {
                        Text(offset.day.description)
                            .font(.title3)
                            .bold()
                        Text("d")
                            .font(.headline)
                            .foregroundStyle(Color.gray)
                    }
                }
                if offset.hour > 0 {
                    HStack(spacing: 2) {
                        Text(offset.hour.description)
                            .font(.title3)
                            .bold()
                        Text("h")
                            .font(.headline)
                            .foregroundStyle(Color.gray)
                    }
                }
                if offset.minute > 0 {
                    HStack(spacing: 2) {
                        Text(offset.minute.description)
                            .font(.title3)
                            .bold()
                        Text("m")
                            .font(.headline)
                            .foregroundStyle(Color.gray)
                    }
                }
                
                HStack(spacing: 2) {
                    Text(offset.second.description)
                        .font(.title3)
                        .bold()
                        .contentTransition(.numericText(countsDown: true))
                    Text("s")
                        .font(.headline)
                        .foregroundStyle(Color.gray)
                }
                
                Spacer()
            }
            .padding(.bottom, 8)
            .foregroundStyle(Color.appText)
       
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(0..<6) { _ in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.appGreen)
                            .stroke(.gray, lineWidth: 1)
                            .frame(height: 12)
                    }
                }
            }
            .frame(height: 12)

            HStack {
                

            }
            
            HStack {
                Spacer()
                
                Text(event.endDate, style: .date)
            }
            .foregroundStyle(Color.appText)
            .padding(.top)

        }
        .background(Color.appWhite)
//        .frame(maxWidth: .infinity)
        .padding()
        
        
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 1)
                .opacity(0.2)
                .shadow(color: .black, radius: 2)
            
        )
        .background(Color.appWhite)
        .cornerRadius(8) /// make the background rounded
        .padding([.leading, .trailing], 16)
        .padding([.top, .bottom], 4)
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

