//
//  OnboardingScreenView.swift
//  CryptyCo
//
//  Created by Анастасия Ларина on 17.03.2024.
//

import SwiftUI

struct OnboardingScreenView: View {
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        VStack(spacing: 20) {
            HStack{
                if currentPage == 1{
                    Text("Hello!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.4)
                } else {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            currentPage -= 1
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    })
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        currentPage = 4
                    }
                }, label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                })
            }
            .foregroundStyle(.black)
            .padding()
            .padding(.top)
            
            Spacer(minLength: 0)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: UIScreen.main.bounds.width * 0.6)
            
            Text(title)
                .font(AppFonts.semibold32.font)
                .foregroundColor(.black)
                .padding(.top)
            
            Text(detail)
                .font(AppFonts.regular15.font)
                .kerning(1.3)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing])
            
            Spacer()
            Spacer()
        }
        .background(bgColor.cornerRadius(10).ignoresSafeArea())
    }
    
}

struct OnboardingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreenView(image: "3calculate", title: "Some title", detail: "Bla  bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla ", bgColor: Color.clear)
    }
}
