
import SwiftUI

struct StatisticRowView: View {
    let nameRow: String
    let infoInRow: String
    
    var body: some View {
        HStack(alignment: .top){
            Text(nameRow)
                .font(AppFonts.medium14.font)
                .foregroundColor(AppColors.grey)
            Spacer()
            Text(infoInRow)
                .font(AppFonts.semibold14.font)
                .foregroundColor(AppColors.black)
                .frame(width: .infinity,alignment: .trailing)
        }
        .padding(.bottom, 10)
    }
}

struct StatisticRowView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticRowView(nameRow: "name", infoInRow: "value")
    }
}
