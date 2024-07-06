//
//  KeeperWidgetBundle.swift
//  KeeperWidget
//
//  Created by Mina Ashna on 30/06/2024.
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
