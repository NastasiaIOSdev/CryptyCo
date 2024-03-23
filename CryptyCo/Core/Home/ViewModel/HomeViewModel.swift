
import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
     
    @Published var statistics: [DataStatistic] = []
    @Published var coins = [CryptoItem]()
    
    @Published var topMovingCoins = [CryptoItem]()
    @Published var portfolioCoins: [CryptoItem] = []
    
    @Published var isLoading: Bool = true
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings
    
    
    private let coinDataService = CryptoDataService()

    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        coinDataService.$topMovingCoins
            .sink { [weak self] (returnedCoins) in
                if (self?.searchText ?? "").isEmpty {
                    self?.topMovingCoins = returnedCoins
                }
            }
            .store(in: &cancellables)
      
        $searchText
            .combineLatest(coinDataService.$coins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.coins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.fetchData()
    }
    
    private func filterAndSortCoins(text: String, coins: [CryptoItem], sort: SortOption) -> [CryptoItem] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        
        sortCoins(sort: sort, coins: &updatedCoins)
        
        return updatedCoins
    }
    
    private func filterCoins(text: String, coins: [CryptoItem]) -> [CryptoItem] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercaseText = text.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercaseText) ||
            coin.symbol.lowercased().contains(lowercaseText) ||
            coin.id.lowercased().contains(lowercaseText)
        }
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CryptoItem]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.marketCapRank < $1.marketCapRank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.marketCapRank > $1.marketCapRank })
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
             coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(coins: [CryptoItem], portfolios: [Portfolio]) -> [CryptoItem] {
        coins
            .compactMap { coin -> CryptoItem? in
                guard let entity = portfolios.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
}
