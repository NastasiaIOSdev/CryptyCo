
import SwiftUI

struct CoinsListView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    let isPortfolio: Bool
    
    @State private var selectedCoin: CryptoItem? = nil
    @State private var showDetailView: Bool = false
    
    init(isPortfolio: Bool = false) {
        self.isPortfolio = isPortfolio
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            
            coinsList
        }
        .background(
            NavigationLink(destination: DetailLoadingView(coin: $selectedCoin), isActive: $showDetailView, label: {
                EmptyView()
            })
        )
    }
}

struct CoinsListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsListView(isPortfolio: true)
            .environmentObject(dev.homeVM)
    }
}

extension CoinsListView {
    private var coinsList: some View {
        ScrollView {
            VStack {
                ForEach(isPortfolio ? viewModel.portfolioCoins : viewModel.coins) { coin in
                    CoinRowView(coin: coin)
                        .onTapGesture {
                            segue(coin: coin)
                        }
                }
            }
        }
    }
    
    private func segue(coin: CryptoItem) {
        selectedCoin = coin
        showDetailView.toggle()
    }
}
