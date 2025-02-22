//
//  ListRow.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 24/07/2024.
//


import SwiftUI
import SwiftData

struct EventView: View {
    var viewModel: EventViewModel
    var eventHandler: (any EventEventHandler)? = nil
    var allEventsHandler: (any AllEventsPresenterEventHandler)
    
    init(viewModel: EventViewModel, eventHandler: (any EventEventHandler)? = nil, allEventHandler: any AllEventsPresenterEventHandler) {
        self.viewModel = viewModel
        
        if eventHandler == nil {
            self.eventHandler = EventPresenter(viewModel: viewModel)
        } else {
            self.eventHandler = eventHandler
        }
        
        self.allEventsHandler = allEventHandler
    }
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let emoji = viewModel.event.emoji {
                    Text(emoji)
                }
                Text(viewModel.event.title)
                    .foregroundStyle(Color.appText)
            }
            .font(.title3)
            .bold()
            
            Divider()
            
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    
                    counterView
                        .multilineTextAlignment(.leading)
                    
                    Gauge(
                        value: viewModel.totalSeconds() - viewModel.secondsLeft(),
                        in: 0...viewModel.totalSeconds(),
                        label: {
                            
                        },
                        currentValueLabel: {
                        }
                        
                    )
                    .tint(Color.appGreen)
                    
                    HStack {
                        Text(viewModel.event.creationDate, style: .date)
                            .foregroundStyle(Color.appText)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        Text(viewModel.event.endDate, style: .date)
                            .foregroundStyle(Color.appText)
                            .multilineTextAlignment(.leading)
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
        .opacity(viewModel.event.endDate > .now ? 1 : 0.5)
        .cornerRadius(8)
        .onReceive(timer) { _ in
            eventHandler?.countdown()
            if viewModel.event.endDate < .now {
                allEventsHandler.clusterEvents()
                timer.upstream.connect().cancel()
            }
        }
        
        
    }
    
    
    var counterView: some View {
        HStack {
            if viewModel.offset.year > 0 {
                HStack(spacing: 2) {
                    Text(viewModel.offset.year.description)
                        .font(.title3)
                        .bold()
                    Text("y")
                        .font(.headline)
                        .foregroundStyle(Color.appTextSecondary)
                }
            }
            if viewModel.offset.month > 0 {
                HStack(spacing: 2) {
                    Text(viewModel.offset.month.description)
                        .font(.title3)
                        .bold()
                    Text("m")
                        .font(.headline)
                        .foregroundStyle(Color.appTextSecondary)
                }
            }
            if viewModel.offset.day > 0 {
                HStack(spacing: 2) {
                    Text(viewModel.offset.day.description)
                        .font(.title3)
                        .bold()
                    Text("d")
                        .font(.headline)
                        .foregroundStyle(Color.appTextSecondary)
                }
            }
            if viewModel.offset.hour > 0 {
                HStack(spacing: 2) {
                    Text(viewModel.offset.hour.description)
                        .font(.title3)
                        .bold()
                    Text("h")
                        .font(.headline)
                        .foregroundStyle(Color.appTextSecondary)
                }
            }
            if viewModel.offset.minute > 0 {
                HStack(spacing: 2) {
                    Text(viewModel.offset.minute.description)
                        .font(.title3)
                        .bold()
                    Text("m")
                        .font(.headline)
                        .foregroundStyle(Color.appTextSecondary)
                }
            }
            
            
            HStack(spacing: 2) {
                Text(viewModel.offset.second >= 0 ? viewModel.offset.second.description : "0")
                    .font(.title3)
                    .bold()
                    .contentTransition(.numericText(countsDown: true))
                Text("s")
                    .font(.headline)
                    .foregroundStyle(Color.appTextSecondary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        let vm = EventViewModel(event: .sampleEvents[0])
        let eventHandler = AllEventsPresenter(viewModel: AllEventsViewModel())
        EventView(viewModel: vm, eventHandler: EventPresenter(viewModel: vm), allEventHandler: eventHandler)
    }
}

