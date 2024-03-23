
import SwiftUI

struct AppLoader: View {
    @Binding var frame: CGFloat
    
    var body: some View {
        Circle()
            .strokeBorder(AppColors.yellow.opacity(1.0), lineWidth: 2)
            .background(Circle().fill(AppColors.yellow.opacity(0.2)))
            .opacity(frame == 10 ? 1 : 0.2)
    }
}

struct LoaderView: View {
    @State var parentLoaderFrame: CGFloat = 10
    @State var childLoaderFrame: CGFloat = 10
    @Binding var showLaunchView: Bool
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { proxy in
            ZStack  {
                AppLoader(frame: $parentLoaderFrame)
                    .frame(width: parentLoaderFrame,
                           height: parentLoaderFrame,
                           alignment: .center)
                Image(uiImage: UIImage(named: "bitcoin") ?? UIImage())
                    .resizable()
                    .background(.white)
                    .frame(width: AppLoaderLayoutValues.profilePictureFrame,
                           height: AppLoaderLayoutValues.profilePictureFrame,
                           alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(AppColors.yellow, lineWidth: 3))
                    .zIndex(1)
                AppLoader(frame: $childLoaderFrame)
                    .frame(width: childLoaderFrame,
                           height: childLoaderFrame,
                           alignment: .center)
            }
            .onAppear {
                withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                    self.parentLoaderFrame = AppLoaderLayoutValues.parentLoaderEndFrame
                    self.childLoaderFrame = AppLoaderLayoutValues.childLoaderEndFrame
                }
            }
            .fillScreen(alignment: .center)
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                        showLaunchView = false
            }
        }
        
    }
}

extension View {
    func fillScreen(alignment: Alignment = .center) -> some View {
        frame(minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: alignment)
    }
}

struct AppLoaderLayoutValues {
    static let profilePictureFrame = UIScreen.main.bounds.size.width * 0.2
    static let parentLoaderEndFrame = UIScreen.main.bounds.size.width
    static let childLoaderEndFrame = UIScreen.main.bounds.size.width * 0.7
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView(showLaunchView: .constant(true))
    }
}
