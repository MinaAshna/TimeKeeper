//
//  CountdownView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import SwiftUI

struct EventView: View {
    @Binding var showCountdownView: Bool
    @State var title: String = ""
    @State var endDate: Date = .now
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
//                    Text("Create an event for the Time Keeper")
//                        .font(.headline)
                    
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
                        showCountdownView = false
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(Color.red)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Add")
                            .bold()
                    }
                }
                
//                ToolbarItem(placement: .principal) {
//                    Text("Time Keeper")
//                }
            }
            .tint(.black)
            
            .padding()
            
        }
    }
}

#Preview {
    EventView(showCountdownView: .constant(true))
}
