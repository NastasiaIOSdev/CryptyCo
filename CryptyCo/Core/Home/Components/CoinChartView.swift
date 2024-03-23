
//import SwiftUI
//
//struct CoinChartView: View {
//    private let dataCoin: [Double]
//    private let maxPrice: Double
//    private let minPrice: Double
//    private let color: Color
//    private let startDate: Date
//    private let endDate: Date
//    @State private var percentage: CGFloat = 0
//    
//    let height: CGFloat
//    let greenColor: Color
//    let redColor: Color
//    
//    init(coin: CryptoItem, height: CGFloat = 40, positiveColor: Color = AppColors.green, negativeColor: Color = AppColors.red) {
//        self.dataCoin = coin.sparklineIn7D?.price ?? []
//        
//        maxPrice = dataCoin.max() ?? 0
//        minPrice = dataCoin.min() ?? 0
//        
//        let priceChange = (dataCoin.last ?? 0) - (dataCoin.first ?? 0)
//        color = priceChange > 0 ? positiveColor : negativeColor
//        
//        endDate = Date(coinGeckoString: coin.lastUpdated ?? "")
//        startDate = endDate.addingTimeInterval(-7*24*60*60)
//        
//        self.height = height
//        self.greenColor = positiveColor
//        self.redColor = negativeColor
//    }
//    
//    var body: some View {
//        ZStack {
//            GeometryReader { geometry in
//                Path { path in
//                    for index in dataCoin.indices {
//                        let xPosition = CGFloat(index + 1) * geometry.size.width / CGFloat(dataCoin.count)
//                        let yAxis = maxPrice - minPrice
//                        let yPosition = (1 - CGFloat((dataCoin[index] - minPrice) / yAxis)) * geometry.size.height
//                        
//                        if index == 0 {
//                            path.move(to: CGPoint(x: xPosition, y: yPosition))
//                        } else {
//                            path.addLine(to: CGPoint(x: xPosition, y: yPosition))
//                        }
//                    }
//                }
//                .trim(from: 0, to: percentage)
//                .stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
//            }
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                    withAnimation(.linear(duration: 2.0)) {
//                        percentage = 1.0
//                    }
//                }
//            }
//        }
//        .frame(height: height)
//        .foregroundColor(AppColors.background)
//        .font(.caption)
//    }
//}
//
//struct CoinChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoinChartView(coin: dev.coin)
//    }
//}
