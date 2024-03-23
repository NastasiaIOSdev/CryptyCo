//
//  ContentView.swift
//  CryptyCo
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct SignInView : View {
    
    // MARK: - Property
    
    @State var email = ""
    @State var pass = ""
    @State var message = ""
    @State var alert = false
    @State var show = false
    @Binding var userEmail: String
    
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
                .font(Font.custom("SFProDisplay-Bold", size: 32))
            
            VStack{
                VStack(alignment: .leading) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 45)
                            .stroke(Color.black.opacity(0.5), lineWidth: 1)
                            .frame(height: 50)
                        TextField("E-mail", text: $email)
                            .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                            .textContentType(.username)
                            .autocapitalization(.none)
                    }
                }.padding(.bottom, 15)
                
                VStack(alignment: .leading){
                    ZStack {
                        RoundedRectangle(cornerRadius: 45)
                            .stroke(Color.black.opacity(0.5), lineWidth: 1)
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
                        } else {
                            UserDefaults.standard.set(true, forKey: "status")
                            UserDefaults.standard.set(self.email, forKey: "email")
                            self.userEmail = self.email
                            NotificationCenter.default.post(name: Notification.Name("statusChange"), object: nil)
                        }
                    }
                }) {
                    Text("Sign In")
                        .foregroundColor(.black)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.yellow)
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
                    .foregroundColor(Color.yellow)
                }
                .padding(.top, 25)
            }
            .sheet(isPresented: $show) {
                SignUpView(show: self.$show, userEmail: self.$userEmail)
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
        SignInView(email: "example@email.com", pass: "password", message: "Incorrect credentials", alert: true, show: false, userEmail: .constant(""))
            .previewDisplayName("Alert Shown")
    }
}
