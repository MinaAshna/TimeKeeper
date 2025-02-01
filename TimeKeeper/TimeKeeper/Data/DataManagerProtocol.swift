//
//  DataManagerProtocol.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 01/02/2025.
//

import Foundation

protocol DataManagerProtocol {
    func delete(event: Event)
    func save(event: Event)
    func readAllEvents() -> [Event]
}
