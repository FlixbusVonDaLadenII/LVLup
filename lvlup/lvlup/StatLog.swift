import Foundation
import SwiftData

@Model
class StatLog {
    var date: Date
    var value: Double
    var tracker: StatTracker?
    
    init(date: Date = .now, value: Double) {
        self.date = date
        self.value = value
    }
}
