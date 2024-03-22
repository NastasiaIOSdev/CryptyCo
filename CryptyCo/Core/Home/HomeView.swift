
import SwiftUI
import FirebaseCore
import FirebaseAuth

struct HomeView : View {

// MARK: - Property
    var email: String
    var body : some View {
        VStack {
            HeaderButtonView(email: email) {
                UserDefaults.standard.set(false, forKey: Constants.UserDefaultStatusKey)
                NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationNamestatusChange), object: nil)
                        }
            BigTitleView()
        }
        .foregroundColor(.white)
    }
}

private extension HomeView {
    enum Constants {
        static let UserDefaultStatusKey = "status"
        static let NotificationNamestatusChange = "statusChange"
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(email: "someMail")
    }
}
