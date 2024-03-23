
import Foundation
import Combine

class CryptoDataService {
    @Published var coins: [CryptoItem] = []
    @Published var topMovingCoins = [CryptoItem]()
    
    private var dataSubscription: AnyCancellable?
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let url = CoinGeckoAPI.url else {
            return
        }
        
        dataSubscription?.cancel()
        
        dataSubscription = fetchDataPublisher(from: url)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    // Handle error
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedCoins) in
                self?.coins = returnedCoins
                self?.configTopMovingCoins()
            })
    }
    
    private func fetchDataPublisher(from url: URL) -> AnyPublisher<[CryptoItem], Error> {
        return NetworkingManager.download(url: url)
            .decode(type: [CryptoItem].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func configTopMovingCoins() {
        let topMovers = coins.sorted(by: { $0.priceChangePercentage24H > $1.priceChangePercentage24H })
        self.topMovingCoins = Array(topMovers.prefix(5))
    }
}

struct CoinGeckoAPI {
    static let baseURL = "https://api.coingecko.com/api/v3/coins/markets"
    static let vsCurrency = "usd"
    static let order = "market_cap_desc"
    static let perPage = "100"
    static let page = "1"
    static let sparkline = "true"
    static let priceChangePercentage = "24h"
    
    static var url: URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "vs_currency", value: vsCurrency),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "per_page", value: perPage),
            URLQueryItem(name: "page", value: page),
            URLQueryItem(name: "sparkline", value: sparkline),
            URLQueryItem(name: "price_change_percentage", value: priceChangePercentage)
        ]
        return components?.url
    }
}
