
import Foundation
import Combine
import SwiftUI

final class CoinDetailViewModel: ObservableObject {
    
    @Published var hederData: [DataStatistic] = []
    @Published var statisticsData: [DataStatistic] = []
    @Published var coin: CryptoItem
    @Published var description: String? = nil

    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CryptoItem) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] returnedArrays in
                self?.hederData = returnedArrays.overview
                self?.statisticsData = returnedArrays.additional
            }
            .store(in: &cancellables)
        
        }
    
    private func mapDataToStatistics(coinDetails: CryptoDetail?, coins: CryptoItem) -> (overview: [DataStatistic], additional: [DataStatistic]) {
        let headerArray = createheaderArray(coin: coin)
        let statisticArray = createStatisticArray(coin: coin, details: coinDetails)
        
        return (headerArray, statisticArray)
    }
    
    private func createheaderArray(coin: CryptoItem) -> [DataStatistic] {
        let price = coin.currentPrice.toCurrency()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStat = DataStatistic(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        return [
            priceStat
        ]
    }
    
    private func createStatisticArray(coin: CryptoItem, details: CryptoDetail?) -> [DataStatistic] {
        let price = coin.currentPrice.toCurrency()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStat = DataStatistic(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let rank = "\(coin.marketCapRank)"
        let rankStat = DataStatistic(title: "Rank", value: rank)
        
        let high = coin.high24H?.toCurrency() ?? "n/a"
        let highStat = DataStatistic(title: "24h High", value: high)
        
        let low = coin.low24H?.toCurrency() ?? "n/a"
        let lowStat = DataStatistic(title: "24h Low", value: low)
        
        
        return [
            priceStat,
            rankStat,
            highStat,
            lowStat
        ]
    }
}
