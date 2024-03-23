
import SwiftUI

struct HeaderBackView: View {
    
    @Binding var userEmail: String
    var signOutAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: signOutAction) {
                Image(Constants.imageNameArrow)
            }
            Text(userEmail)
                .padding(Constraints.paddingEmailText)
                .padding([.leading, .trailing], Constraints.paddingEmailTextLeading)
                .foregroundColor(AppColors.black)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: Constraints.textBackgroundCornerRadius))
            Spacer()
        }
    }
}

private extension HeaderBackView {
     enum Constants {
        static let imageNameArrow = "arrowLeft"
    }
    
     enum Constraints {
        static let paddingEmailText: CGFloat = 5
        static let paddingEmailTextLeading: CGFloat = 15
        static let textBackgroundCornerRadius: CGFloat = 12
        static let arrowImageSpacing: CGFloat = 4
    }
}

struct HeaderButtonView_Previews: PreviewProvider {
    @State static var userEmail = "email"
    
    static var previews: some View {
        HeaderBackView(userEmail: $userEmail, signOutAction: {})
            .previewLayout(.sizeThatFits)
    }
}
