//
//  ContentView.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import SwiftUI
import SwiftData

struct TimeKeeperView: View {
    @Environment(\.modelContext) var modelContext
    @Query var events: [Event]
    @State var isPresentingNewEventView = false
    
    var body: some View {
        NavigationStack {
//            ScrollView {
//                LazyVGrid(columns: [.init(.adaptive(minimum: 300))]) {
//                    ForEach(events, id:\.id) { event in
//                        Button {
//                            
//                        } label: {
//                            EventCardView(event: event)
//                                .tint(.appText)
//                        }
//
//                    }
//                }
//                .padding([.leading, .trailing], 8)
//            }

          
            VStack {
                
                List(events) { event in
                    VStack {
                        Button {
                        } label: {
                            EventCardView(event: event)
                                .tint(.appText)
                        }
                        .tint(.black)
                        .buttonStyle(.borderless)
                        .swipeActions {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                modelContext.delete(event)
                            }
                            Button("Edit", systemImage: "pencil", role: .none) {
                                isPresentingNewEventView = true
                            }
                            .tint(Color.appGreen)
                        }
                    }
                    .listRowSeparatorTint(Color.appGray, edges: .all)

                }
                .listStyle(.inset)
            }
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isPresentingNewEventView = true
                    } label: {
                        Image(systemName: "hourglass.badge.plus")
                            .tint(.primary)
                    }
                    .tint(.black)
                    .padding()
                }
            }
        }
        .sheet(isPresented: $isPresentingNewEventView) {
            NewEventView(isPresentingNewEventView: $isPresentingNewEventView)
        }
    }
}

#Preview {
    return TimeKeeperView()
        .modelContainer(DataController.previewContainer)
}

