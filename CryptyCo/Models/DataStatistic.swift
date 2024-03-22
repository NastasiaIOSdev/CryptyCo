
import Foundation

struct DataStatistic: Identifiable {
    var id = UUID().uuidString
    let name: String
    var coinValue: String?
    let percentage: Double?
    
    init(title: String, value: String? = nil, percentageChange: Double? = nil) {
        self.name = title
        self.coinValue = value
        self.percentage = percentageChange
    }
    
    mutating func updateValue(_ newValue: String) {
        self.coinValue = newValue
    }
}
