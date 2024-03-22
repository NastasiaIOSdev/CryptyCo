
import Foundation

struct CryptoDetail: Codable {
    let id: String
    let symbol: String
    let name: String
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
    }
    
    init(id: String, symbol: String, name: String, blockTimeInMinutes: Int? = nil, hashingAlgorithm: String? = nil) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.blockTimeInMinutes = blockTimeInMinutes
        self.hashingAlgorithm = hashingAlgorithm
    }
}
