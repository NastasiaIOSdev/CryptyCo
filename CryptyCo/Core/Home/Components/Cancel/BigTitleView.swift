//
//  BigTitleView.swift
//  CryptyCo
//
//  Created by Анастасия Ларина on 17.03.2024.
//

import SwiftUI

struct BigTitleView: View {
    
    var body: some View {
        HStack {
            (Text(Constants.title)
                .foregroundColor(.black)
             +
             Text(Constants.title2)
                .foregroundColor(AppColors.grey)
            )
            .font(AppFonts.medium28.font)
            .padding()
            Spacer()
        }
    }
}

private extension BigTitleView {
    private enum Constants {
        static let title = "Coin"
        static let title2 = "Mаrket"
    }
}

struct BigTitleView_Previews: PreviewProvider {
    static var previews: some View {
        BigTitleView()
    }
}
