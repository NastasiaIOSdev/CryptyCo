
import Foundation

struct CurrencyDTO: Codable {
    let Valute: [String: Currency]
}

struct Currency: Codable {
    let Value: Double
}
