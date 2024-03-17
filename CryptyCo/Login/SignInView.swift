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
                Image("singnIn")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.size.width * 0.6)
            }
             Text("Sign In")
                .fontWeight(.heavy)
                .padding([.top,.bottom], 20)
                .font(AppFonts.bold32.font)
            
            VStack{
                VStack(alignment: .leading) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 45)
                            .stroke(AppColors.background, lineWidth: 1)
                            .frame(height: 50)
                        TextField("E-mail", text: $email)
                            .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                    }
                }.padding(.bottom, 15)
                
                VStack(alignment: .leading){
                    ZStack {
                        RoundedRectangle(cornerRadius: 45)
                            .stroke(AppColors.background, lineWidth: 1)
                            .frame(height: 50)
                        SecureField("Password", text: $pass)
                            .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                    }
                }
            }.padding()
            
            VStack{
                Button(action: {
                    signInWithEmail(email: self.email, password: self.pass) { (verified, status) in
                        if !verified {
                            self.message = status
                            self.alert.toggle()
                        }
                        else{
                            UserDefaults.standard.set(true, forKey: "status")
                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                        }
                    }
                }) {
                    Text("Sign In")
                        .foregroundColor(.black)
                        .padding()
                }
                    .frame(maxWidth: .infinity)
                    .background(AppColors.yellow)
                    .clipShape(Capsule())
                    .padding(.top, 30)
                    .padding()
                    .alert(isPresented: $alert) {
                        Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("Ok")))
                }
                
                HStack(spacing: 8){
                    Text("Don't Have An Account ?").foregroundColor(Color.gray.opacity(0.5))
                    Button(action: {
                        self.show.toggle()
                    }) {
                        Text("Sign Up")
                    }
                    .foregroundColor(AppColors.yellow)
                }
                .padding(.top, 25)
            }
            .sheet(isPresented: $show) {
                SignUpView(show: self.$show)
            }
        }
    }
}

extension SignInView {
    func signInWithEmail(email: String,password : String,completion: @escaping (Bool,String)->Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if err != nil{
                completion(false,(err?.localizedDescription)!)
                return
            }
            completion(true,(res?.user.email)!)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
