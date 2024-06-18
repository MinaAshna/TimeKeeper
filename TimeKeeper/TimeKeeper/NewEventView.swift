//
//  EventEditView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import SwiftUI

struct NewEventView: View {
    @Environment(\.modelContext) var modelContext
    @State private var event = Event.emptyEvent
    @Binding var isPresentingNewEventView: Bool
    
    var body: some View {
        NavigationStack {
            EventView(event: $event)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            isPresentingNewEventView = false
                        } label: {
                            Text("Cancel")
                                .foregroundStyle(Color.red)
                        }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            isPresentingNewEventView = false
                            modelContext.insert(event)
                        } label: {
                            Text("Add")
                                .bold()
                                .foregroundStyle(Color.primary)
                        }
                    }
                }
        }
    }
}

#Preview {
    NewEventView(isPresentingNewEventView: .constant(true))
}
