
import Foundation
import Combine

final class CoinDetailDataService {
    @Published var coinDetails: CryptoDetail?
    private var dataDetailSubscription: AnyCancellable?
    let coin: CryptoItem
    
    init(coin: CryptoItem) {
        self.coin = coin
        self.coinDetails = nil
        fetchCoinDetails()
    }
    
    func fetchCoinDetails() {
        guard let url = CoinAPI.urlForCoinDetail(id: coin.id) else {
            print("Invalid URL for coin details")
            return
        }
        
        dataDetailSubscription?.cancel()
        dataDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CryptoDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedCoinDetails) in
                self?.coinDetails = returnedCoinDetails
            })
    }
}

struct CoinAPI {
    static let baseURL = "https://api.coingecko.com/api/v3"
    
    static func urlForCoinDetail(id: String) -> URL? {
        var components = URLComponents(string: baseURL + "/coins/\(id)")
        components?.queryItems = [
            URLQueryItem(name: "localization", value: "false"),
            URLQueryItem(name: "tickers", value: "false"),
            URLQueryItem(name: "market_data", value: "false"),
            URLQueryItem(name: "community_data", value: "false"),
            URLQueryItem(name: "developer_data", value: "false"),
            URLQueryItem(name: "sparkline", value: "false")
        ]
        return components?.url
    }
}
