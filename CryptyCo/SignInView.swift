//
//  ContentView.swift
//  CryptyCo
//
//  Created by Анастасия Ларина on 16.03.2024.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct SignInView : View {
    
    @State var email = ""
    @State var pass = ""
    @State var message = ""
    @State var alert = false
    @State var show = false
    
    var body : some View{
        VStack {
            VStack {
                Image("SngnIn")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.size.width * 0.6)
            }
             Text("Sign In").fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom], 20)
            VStack{
                
                VStack(alignment: .leading){
                    
                    VStack(alignment: .leading){
                        
                       // Text("E-mail").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        
                        HStack{
                            
                            TextField("E-mail", text: $email)
                            
                            if email != ""{
                                
                                Image("check")
                                    .foregroundColor(Color.init(.label))
                            }
                        }
                        
                        Divider()
                        
                    }.padding(.bottom, 15)
                    
                    VStack(alignment: .leading){
                        
                       // Text("Password").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        
                        SecureField("Password", text: $pass)
                        
                        Divider()
                    }
                      
                }.padding(.horizontal, 6)
             
            }.padding()
            
            VStack{
                
                Button(action: {
                    
                }) {
                    
                    Text("Sign In").foregroundColor(.black).frame(width: UIScreen.main.bounds.width - 120).padding()
                    
                    
                }.background(AppColors.yellow)
                    .clipShape(Capsule())
                    .padding(.top, 45)
                
                HStack(spacing: 8){
                    
                    Text("Don't Have An Account ?").foregroundColor(Color.gray.opacity(0.5))
                    
                    Button(action: {
                        
                        self.show.toggle()
                        
                    }) {
                        
                        Text("Sign Up")
                        
                    }.foregroundColor(AppColors.yellow)
                    
                }.padding(.top, 25)
                
            }.sheet(isPresented: $show) {
                
                SignUpView(show: self.$show)
            }
        }
    }

}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
