//
//  KeeperWidgetLiveActivity.swift
//  KeeperWidget
//
//  Created by Mina Ashna on 06/07/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct KeeperWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct KeeperWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: KeeperWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension KeeperWidgetAttributes {
    fileprivate static var preview: KeeperWidgetAttributes {
        KeeperWidgetAttributes(name: "World")
    }
}

extension KeeperWidgetAttributes.ContentState {
    fileprivate static var smiley: KeeperWidgetAttributes.ContentState {
        KeeperWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: KeeperWidgetAttributes.ContentState {
         KeeperWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: KeeperWidgetAttributes.preview) {
   KeeperWidgetLiveActivity()
} contentStates: {
    KeeperWidgetAttributes.ContentState.smiley
    KeeperWidgetAttributes.ContentState.starEyes
}
