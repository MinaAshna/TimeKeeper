//
//  KeeperWidget.swift
//  KeeperWidget
//
//  Created by Mina Ashna on 06/07/2024.
//

import WidgetKit
import SwiftUI

struct EventStatusProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> EventStatusEntry {
        EventStatusEntry(event: .sampleEvents.first!, date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> EventStatusEntry {
        EventStatusEntry(event: .sampleEvents.first!, date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<EventStatusEntry> {
        
        var entries: [EventStatusEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = EventStatusEntry(event: .sampleEvents.first!,
                                         date: entryDate,
                                         configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct EventStatusEntry: TimelineEntry {
    let event: Event
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct KeeperWidgetEntryView : View {
    var entry: EventStatusProvider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Favorite Emoji:")
            Text(entry.configuration.favoriteEmoji)
        }
    }
}

struct KeeperWidget: Widget {
    let kind: String = "com.impact.betaupdates.KeeperWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: EventStatusProvider()) { entry in
            KeeperWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Time Keepper Widget")
        .description("Shows the selected countdown event by the user")
        .supportedFamilies([.systemSmall])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    KeeperWidget()
} timeline: {
    EventStatusEntry(event: .sampleEvents.first!, date: .now, configuration: .smiley)
    EventStatusEntry(event: .sampleEvents.first!, date: .now, configuration: .starEyes)
}
