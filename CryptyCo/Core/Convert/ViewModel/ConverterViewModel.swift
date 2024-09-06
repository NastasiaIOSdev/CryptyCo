
import Foundation
import Combine

final class ConverterViewModel: ObservableObject {

     @Published var selectedCoin: CryptoItem?
     @Published var usdToRubRate: Double = 0.0
     @Published var amountInDollars: Double = 0.0
     @Published var coinDetails: [CryptoItem] = []

     private var homeViewModel: HomeViewModel

     init(homeViewModel: HomeViewModel) {
         self.homeViewModel = homeViewModel
     }

    func updateSelectedCoin(_ coin: CryptoItem?) {
        self.selectedCoin = coin
    }
    
    func updateAmountInDollars(_ amount: Double) {
        self.amountInDollars = amount
    }
    
    func calculateAmountInRubles() -> Double {
        return amountInDollars * usdToRubRate
    }
}
