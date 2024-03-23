
import SwiftUI

struct StatisticView2: View {
    let stat: DataStatistic
    
    var body: some View {
        VStack(alignment: .center){
            Text(stat.coinValue ?? "Nan")
                .font(AppFonts.medium28.font)
                .padding(.bottom,1)
            
            HStack {
                Text(stat.percentage?.toPercentString() ?? "" )
                    .font(AppFonts.semibold14.font)
            }
            .foregroundColor(AppColors.black)
            .opacity(stat.percentage == nil ? 0.0 : 1.0)

        }
    }
}

struct StatisticView2_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView2(stat: dev.stat1)
                .previewLayout(.sizeThatFits)
        }
    }
}

