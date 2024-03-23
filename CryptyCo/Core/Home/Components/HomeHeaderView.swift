
import SwiftUI
import FirebaseCore
import FirebaseAuth

struct HomeHeaderView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @State private var isConverterViewPresented = false
    @Binding var userEmail: String
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    HeaderBackView(userEmail: $userEmail) {
                        UserDefaults.standard.set(false, forKey: Constants.UserDefaultStatusKey)
                        NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationNamestatusChange), object: nil)
                    }
                    
                    Spacer()
                    HStack(spacing: 4)  {
                        Image("sort")
                            .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180))
                    }
                    .onTapGesture {
                        withAnimation(.default) {
                            viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
                        }
                    }
                    
                }
                .padding()
                
                HStack {
                    (Text("Coin ")
                     +
                     Text("Market")
                        .foregroundColor(AppColors.grey)
                    )
                    .font(AppFonts.medium28.font)
                    .padding([.leading, .trailing])
                    Spacer()
                }
                
                
                HStack(spacing: 15) {
                    Image("arrow")
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
                        .onTapGesture {
                            withAnimation(.default) {
                                viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
                            }
                        }
                    
                    CoinSearchBarView(searchText: $viewModel.searchText)
                }
                .padding([.leading, .trailing])
            }
            .background(AppColors.yellow)
        }
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel()
        return HomeHeaderView(userEmail: .constant("someMail"))
            .environmentObject(viewModel)
    }
}

private extension HomeHeaderView {
    enum Constants {
        static let UserDefaultStatusKey = "status"
        static let NotificationNamestatusChange = "statusChange"
    }
}
