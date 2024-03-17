//
//  OnboardingCaruselView.swift
//  CryptyCo
//
//  Created by Анастасия Ларина on 17.03.2024.
//

import SwiftUI

struct OnboardingCaruselView: View {
    @AppStorage("currentPage") var currentPage = 1
    
    var totalPages = 3
    
    var body: some View {
        ZStack {
            if currentPage == 1 {
                OnboardingScreenView(image: "1search", title: "Quick search!", detail: "Find information about the currency you are interested in.", bgColor: Color(.white))
                    .transition(.scale)
            }
            if currentPage == 2 {
                OnboardingScreenView(image: "2graph", title: "See the charts!", detail: "Track the dynamics of changes in the price of the currency on the charts.", bgColor: Color(.white))
                    .transition(.scale)
            }
            if currentPage == 3 {
                OnboardingScreenView(image: "3calculate", title: "Calculate the price!", detail: "Convert the value of any currency of interest.", bgColor: Color(.white))
                    .transition(.scale)
            }
            Spacer()
        }
        .overlay(
            Button(action: {
                withAnimation(.easeInOut) {
                    if currentPage <= totalPages {
                        currentPage += 1
                    } else {
                        currentPage = 1
                    }
                }
            }, label: {
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
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                .stroke(AppColors.yellow, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-15)
                    )
            })
            .padding(.bottom, 30),
            alignment: .bottom
        )
        .onChange(of: currentPage) { newValue in
            if newValue > totalPages {
                UserDefaults.standard.setValue(true, forKey: "status")
                NotificationCenter.default.post(name: Notification.Name("statusChange"), object: nil)
            }
        }
    }
}

struct OnboardingCaruselView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCaruselView()
    }
}
