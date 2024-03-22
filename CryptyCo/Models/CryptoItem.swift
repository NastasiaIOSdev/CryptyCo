
import Foundation

struct CryptoItem: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCapRank: Int
    let high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H: Double
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
    }
  
    static func == (lhs: CryptoItem, rhs: CryptoItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func updateHoldings(amount: Double) -> CryptoItem {
        return CryptoItem(id: id,
                        symbol: symbol,
                        name: name,
                        image: image,
                        currentPrice: currentPrice,
                        marketCapRank: marketCapRank,
                        high24H: high24H,
                        low24H: low24H,
                        priceChange24H: priceChange24H,
                        priceChangePercentage24H: priceChangePercentage24H,
                        lastUpdated: lastUpdated,
                        sparklineIn7D: sparklineIn7D,
                        priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency)
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]
}

enum JSONNull: Codable, Equatable {
    case null

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .null
        } else {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

extension CryptoItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
