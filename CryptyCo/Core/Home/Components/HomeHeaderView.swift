
import SwiftUI
//
//struct HomeHeaderView: View {
//    @EnvironmentObject var viewModel: HomeViewModel
//    @State private var isConverterViewPresented = false
//    
//    var body: some View {
//        VStack {
//            VStack {
//                HStack {
//                    Button(action: {
//                        UserDefaults.standard.set(false, forKey: "status")
//                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
//                    }) {
//                        Image("arrowLeft")
//                    }
//                    
//                    Text("Name")
//                        .padding(.leading, 7)
//                    
//                    Spacer()
//                    HStack(spacing: 4)  {
//                        Image("sort")
//                            .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180))
//                    }
//                    .onTapGesture {
//                        withAnimation(.default) {
//                            viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
//                        }
//                    }
//                    
//                }
//                .padding()
//                
//                HStack {
//                    (Text("Coin ")
//                     +
//                     Text("Market")
//                        .foregroundColor(AppColors.grey)
//                    )
//                    .font(AppFonts.medium28.font)
//                    .padding([.leading, .trailing])
//                    Spacer()
//                }
//                
//                
//                HStack(spacing: 15) {
//                    Image("arrow")
//                        .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
//                        .onTapGesture {
//                            withAnimation(.default) {
//                                viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
//                            }
//                        }
//                    
//                    CoinSearchBarView(searchText: $viewModel.searchText)
//                }
//                .padding([.leading, .trailing])
//            }
//            .background(AppColors.yellow)
//        }
//    }
//}
//
//struct HomeHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeHeaderView()
//            .environmentObject(HomeViewModel())
//    }
//}
