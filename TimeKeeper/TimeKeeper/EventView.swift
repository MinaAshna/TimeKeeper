//
//  CountdownView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import SwiftUI

struct EventView: View {
    @Binding var event: Event
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    TextField("Title", text: $event.title)
                        .padding(24)
//                        .background(Color.appBackground)
                        .cornerRadius(12)
                    
                    DatePicker("End Date",
                               selection: $event.endDate)
                        .datePickerStyle(.graphical)
                    
                    Spacer()
                }
            }
            .padding()
        }
    }
}

#Preview {
    return EventView(event: .constant(Event.sampleEvents[0]))
}
