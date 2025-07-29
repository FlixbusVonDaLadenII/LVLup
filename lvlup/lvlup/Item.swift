//
//  Item.swift
//  lvlup
//
//  Created by Felix on 25.07.25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
