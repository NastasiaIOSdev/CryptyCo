
import SwiftUI
import Kingfisher

struct CoinRowView: View {
    let coin: CryptoItem
    @StateObject private var viewModel: CoinDetailViewModel
    
    init(coin: CryptoItem) {
        self.coin = coin
        _viewModel = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }
    
    var body: some View {
        HStack(spacing: 4) {
           
            ZStack{
                Circle()
                    .fill(AppColors.background)
                    .frame(width: 50, height: 50)
                Circle()
                    .fill(.white)
                    .frame(width: 48, height: 48)
                KFImage(URL(string: coin.image))
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 35, height: 35)
            }
            Spacer()
        
            coinNameInfoSection
            Spacer()
            
            coinGraphSection
            Spacer()
            
            coinPriceSection
        }
        .padding(.vertical, 4)
        .background(
            Color.theme.background.opacity(0.001)
        )
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin)
    }
}

extension CoinRowView {
    private var coinNameInfoSection: some View {
        VStack (alignment: .leading, spacing: 4) {
            Text(coin.name)
                .font(AppFonts.medium18.font)
                .fontWeight(.semibold)
                .padding(.leading, 4)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.symbol.uppercased())
                .font(AppFonts.medium14.font)
                .padding(.leading, 6)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .foregroundStyle(AppColors.black)
        .padding(.leading, 2)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
        
    private var coinGraphSection: some View {
        VStack (alignment: .leading, spacing: 4) {
            VStack {
                CoinChartView(coin: viewModel.coin, height: 40, positiveColor: AppColors.green, negativeColor: AppColors.red)
            }
            .padding(.horizontal, 15)
        }
        .foregroundStyle(AppColors.black)
        .padding(.leading, 2)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    private var coinPriceSection: some View {
        VStack (alignment: .trailing, spacing: 4) {
            Text(coin.currentPrice.toCurrency())
                .font(AppFonts.medium18.font)
                .fontWeight(.semibold)
                .padding(.leading, 4)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.priceChangePercentage24H.toPercentString())
                .font(AppFonts.medium12.font)
                .padding(.leading, 6)
                .foregroundColor(coin.priceChangePercentage24H > 0 ? AppColors.green : AppColors.red)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .padding(.leading, 2)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}
