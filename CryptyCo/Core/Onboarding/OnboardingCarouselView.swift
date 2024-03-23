
import SwiftUI
import FirebaseCore
import FirebaseAuth

struct OnboardingCarouselView: View {
    @Binding var showSignInView: Bool
    @State private var currentPage = 1
    
    var body: some View {
        ZStack {
            if currentPage == 1 {
                OnboardingScreenView(image: "1search", title: "Quick search!", detail: "Find information about the currency you are interested in.", bgColor: Color(.white), showSignInView: $showSignInView)
                    .transition(.scale)
            }
            if currentPage == 2 {
                OnboardingScreenView(image: "2graph", title: "See the charts!", detail: "Track the dynamics of changes in the price of the currency on the charts.", bgColor: Color(.white), showSignInView: $showSignInView)
                    .transition(.scale)
            }
            if currentPage == 3 {
                OnboardingScreenView(image: "3calculate", title: "Calculate the price!", detail: "Convert the value of any currency of interest.", bgColor: Color(.white), showSignInView: $showSignInView)
                    .transition(.scale)
            }
            Spacer()
        }
        .overlay(
            Button(action: {
                withAnimation(.easeInOut) {
                    if currentPage <= 3 {
                        currentPage += 1
                    }
                    if currentPage > 3 {
                        let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                        self.showSignInView = !status
                    }
                }
            }) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(AppColors.yellow)
                    .clipShape(Circle())
                    .overlay(
                        ZStack {
                            Circle()
                                .stroke(Color.black.opacity(0.07), lineWidth: 4)
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / 3)
                                .stroke(AppColors.yellow, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-15)
                    )
            }
            .padding(.bottom, 30),
            alignment: .bottom
        )
    }
}

struct OnboardingCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCarouselView(showSignInView: .constant(false))
    }
}
