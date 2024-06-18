//
//  EventDetailView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import SwiftUI

struct EventDetailView: View {
    @State private var editingEvent = Event.emptyEvent
    @State private var isPresentingEditView = false
    var event: Event
    
    var body: some View {
        VStack {
            Text(event.title)
            Button {
                isPresentingEditView = true
                editingEvent = event
            } label: {
                Text("Edit")
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
}

#Preview {
    EventDetailView(event: Event.sampleEvents[0])
}
