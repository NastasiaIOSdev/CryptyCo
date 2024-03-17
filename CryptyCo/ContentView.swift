import SwiftUI
import FirebaseCore
import FirebaseAuth

struct ContentView: View {
    
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State var userEmail = UserDefaults.standard.value(forKey: "email") as? String ?? ""
        
    var body: some View {
        VStack {
            OnboardingCaruselView()
        }
//        VStack {
//            if status {
//                HomeView(email: userEmail)
//            }
//            else{
//                SignInView(userEmail: $userEmail)
//            }
//        }.animation(.spring())
//            .onAppear {
//                NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
//                    let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
//                    self.status = status
//                }
//            }
    }
}
