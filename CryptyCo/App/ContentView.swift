
import SwiftUI
import FirebaseCore
import FirebaseAuth

struct ContentView: View {
    @StateObject var viewModel = HomeViewModel()
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State var userEmail = UserDefaults.standard.value(forKey: "email") as? String ?? ""
    @State var showLoader = true
    @State var showSignInView = false
    
    init() {
        UITabBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(AppColors.black)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(AppColors.red)]
    }
    
    var body: some View {
        Group {
            if showLoader {
                LoaderView(showLaunchView: $showLoader)
            } else {
                if status {
                    TabView {
                        NavigationView {
                            HomeView(userEmail: userEmail)
                        }
                        .navigationViewStyle(StackNavigationViewStyle())
                        .environmentObject(viewModel)
                        .tabItem {
                            Image(systemName: "house.fill")
                        }
                        .tag(0)

                     ConverterView()
                            .tabItem {
                                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                            }
                            .tag(1)
                    }
                    .background(Color.white)
                    
                } else if showSignInView {
                    SignInView(userEmail: $userEmail)
                } else {
                    OnboardingCarouselView(showSignInView: $showSignInView)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
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

