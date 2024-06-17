//
//  CountdownView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import SwiftUI

struct EventEditView: View {
    @Binding var showEventView: Bool
    @Binding var events: [EventViewModel]
    @State var title: String = ""
    @State var endDate: Date = .now
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    TextField("Title", text: $title)
                        .padding(24)
                        .background(Color.background)
                        .cornerRadius(12)
                    
                    DatePicker("End Date", selection: $endDate)
                        .datePickerStyle(.graphical)
                    
                    
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        showEventView = false
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(Color.red)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        events.append(EventViewModel(title: title,
                                                     endDate: endDate))
                        showEventView = false
                    } label: {
                        Text("Add")
                            .bold()
                            .foregroundStyle(Color.primary)
                    }
                }
            }
           
            
            .padding()
            
        }
    }
}

#Preview {
    @State var events: [EventViewModel] = []
    return EventEditView(showEventView: .constant(true),
              events: $events)
}
