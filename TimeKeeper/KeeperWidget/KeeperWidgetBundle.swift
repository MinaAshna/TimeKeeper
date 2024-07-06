//
//  KeeperWidgetBundle.swift
//  KeeperWidget
//
//  Created by Mina Ashna on 06/07/2024.
//

import WidgetKit
import SwiftUI

@main
struct KeeperWidgetBundle: WidgetBundle {
    var body: some Widget {
        KeeperWidget()
        KeeperWidgetControl()
        KeeperWidgetLiveActivity()
    }
}
