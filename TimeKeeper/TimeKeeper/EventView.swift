//
//  CountdownView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import SwiftUI
import SwiftData

struct EventView: View {
    @Binding var event: Event
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    TextField("Title", text: $event.title, axis: .vertical)
                        .padding(16)
                        .frame(height: 60)
                        .background(Color.appGray)
                        .cornerRadius(12)
                    
                    DatePicker("End Date",
                               selection: $event.endDate,
                               in: Date()...)
                    .datePickerStyle(.graphical)
                    
                    Spacer()
                }
            }
            .padding()
        }
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Event.self, configurations: configuration)
    let sampleEvent = Event(title: "Event1",
                            emoji: "🤩",
                            creationDate: Calendar.current.date(byAdding: .month, value: -1, to: Date.init())!,
                            endDate: Calendar.current.date(byAdding: .month, value: 1, to: Date.init())!)
    EventView(event: .constant(sampleEvent))
        .modelContainer(container)
}
