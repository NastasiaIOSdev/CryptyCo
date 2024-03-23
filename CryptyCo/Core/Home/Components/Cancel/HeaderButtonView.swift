
import SwiftUI

struct HeaderButtonView: View {
    
    var email: String
    var signOutAction: () -> Void
        
        var body: some View {
            HStack {
                Button(action: signOutAction) {
                    Image(Constants.imageNameArrow)
                }
                Text(email)
                    .padding(Constraints.paddingEmailText)
                    .padding([.leading, .trailing], Constraints.paddingEmailTextLeading)
                    .foregroundColor(AppColors.black)
                    .background(AppColors.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: Constraints.textBackgroundCornerRadius))
                
                Spacer()
                
                HStack(spacing: Constraints.arrowImageSpacing) {
                    Image(Constants.imageNameSort)
                }
            }
            .padding()
        }
}

private extension HeaderButtonView {
     enum Constants {
        static let imageNameArrow = "arrowLeft"
        static let imageNameSort = "sort"
    }
    
     enum Constraints {
        static let paddingEmailText: CGFloat = 5
        static let paddingEmailTextLeading: CGFloat = 15
        static let textBackgroundCornerRadius: CGFloat = 12
        static let arrowImageSpacing: CGFloat = 4
    }
}

struct HeaderButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderButtonView(email: "email", signOutAction: {})
            .previewLayout(.sizeThatFits)
    }
}
