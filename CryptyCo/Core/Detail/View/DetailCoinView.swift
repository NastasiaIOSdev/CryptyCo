
import SwiftUI
import Kingfisher

struct DetailLoadingView: View {
    @Binding var coin: CryptoItem?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailCoinView(coin: coin)
            }
        }
    }
}

struct DetailCoinView: View {
    @StateObject private var viewModel: CoinDetailViewModel
    let coin: CryptoItem
    
    init(coin: CryptoItem) {
        self.coin = coin
        _viewModel = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            LinearGradient(
                           colors: [Color(red: 0.99, green: 0.87, blue: 0.18), Color(red: 0.99, green: 0.87, blue: 0.18)] , startPoint: .top, endPoint: .bottom)
                       .ignoresSafeArea()
                VStack(alignment: .center, spacing: 20) {
                    Spacer()
                    headerDetailInfo
                    
                    CoinChartView(coin: viewModel.coin, height: 200, positiveColor: .black, negativeColor: .black)
                            .padding([.leading,.trailing, .top])
                    
                    Spacer()
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Market Statistic")
                            .foregroundColor(AppColors.black)
                            .font(AppFonts.medium20.font)
                        
                        additionalListInfo
                    }
                    .padding([.leading, .trailing], 25)
                    .padding(.top, 60)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 35).offset(x: 0, y: 35))
                }
        }
        .navigationTitle(viewModel.coin.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

struct DetailCoinView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCoinView(coin: dev.coin)
    }
}

extension DetailCoinView {

    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = viewModel.description, !coinDescription.isEmpty {
            }
        }
    }
    
    private var headerDetailInfo: some View {
        ForEach(viewModel.hederData) { stat in
            StatisticView2(stat: stat)
        }
    }
    
    private var additionalListInfo: some View {
        ForEach(viewModel.statisticsData) { stat in
            StatisticView(stat: stat) }
    }
}
