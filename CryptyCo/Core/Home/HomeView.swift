import SwiftUI
import FirebaseCore
import FirebaseAuth

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State var userEmail = ""
    
    var body: some View {
        VStack {
            HomeHeaderView(userEmail: $userEmail)
            homeCoinsView
                .transition(.move(edge: .leading))
                .padding()
            Spacer(minLength: 0)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
            HomeView()
       
        .environmentObject(dev.homeVM)
    }
}

extension HomeView {
    private var homeCoinsView: some View {
        ScrollView (.vertical, showsIndicators: false) {
            CoinsListView(isPortfolio: showPortfolio)
        }
    }
}
