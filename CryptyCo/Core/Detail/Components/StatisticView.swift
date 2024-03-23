
import SwiftUI

struct StatisticView: View {
    let stat: DataStatistic
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 25) {
                Text(stat.name)
                    .font(AppFonts.medium14.font)
                    .foregroundColor(AppColors.grey)
                Spacer()
                Text(stat.coinValue ?? "Nan")
                    .foregroundColor(.black)
                    .font(AppFonts.semibold14.font)
                    
            }
            .padding(.bottom, 5)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(stat: dev.stat1)
                .previewLayout(.sizeThatFits)
        }
    }
}
