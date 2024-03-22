
import SwiftUI
import FirebaseCore
import FirebaseAuth

struct ContentView: View {
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State var userEmail = UserDefaults.standard.value(forKey: "email") as? String ?? ""
    @State var showLoader = true
    @State var showSignInView = false

    var body: some View {
        Group {
            if showLoader {
                LoaderView(showLaunchView: $showLoader)
            } else {
                if status {
                    HomeView(email: userEmail)
                } else if showSignInView {
                    SignInView(userEmail: $userEmail)
                } else {
                    OnboardingCarouselView(showSignInView: $showSignInView)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.showLoader = false
                }
            }

            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                withAnimation {
                    self.status = status
                }
            }
        }
    }
}
