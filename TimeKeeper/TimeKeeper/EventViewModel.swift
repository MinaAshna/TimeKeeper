//
//  Event.swift
//  TimeKeeper
//
//  Created by Mina Ashna on 17/06/2024.
//

import Foundation
import SwiftUI

@Observable
class EventViewModel {
    var title: String = ""
    var endDate: Date = .now
}
