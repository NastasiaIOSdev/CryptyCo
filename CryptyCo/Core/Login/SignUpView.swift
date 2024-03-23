
import SwiftUI
import FirebaseCore
import FirebaseAuth

struct SignUpView : View {

// MARK: - Property
    
    @State var email = ""
    @State var pass = ""
    @State var message = ""
    @State var alert = false
    @Binding var show : Bool
    @Binding var userEmail: String
    
    var body : some View {
        VStack {
            
            HStack {
                Button(action: {
                    self.show.toggle()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.top, 30)
            .padding(.leading, 16)
            Spacer()
            
            Text("Sign Up")
                .fontWeight(.heavy)
                .font(AppFonts.bold32.font)
                .padding([.top,.bottom], 20)
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 45)
                            .stroke(AppColors.background, lineWidth: 1)
                            .frame(height: 50)
                        TextField("Email", text: $email)
                            .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                            .textContentType(.username)
                            .autocapitalization(.none)
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
                
                Button(action: {
                    signUpWithEmail(email: self.email, password: self.pass) { (verified, status) in
                        if !verified {
                            self.message = status
                            self.alert.toggle()
                        } else {
                            UserDefaults.standard.set(true, forKey: "status")
                            self.show.toggle()
                            UserDefaults.standard.set(self.email, forKey: "email")
                            self.userEmail = self.email
                            self.show.toggle()
                            NotificationCenter.default.post(name: Notification.Name("statusChange"), object: nil)
                        }
                    }
                }) {
                    Text("Sign Up")
                        .foregroundColor(.black)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(AppColors.yellow)
                .clipShape(Capsule())
                .padding(.top, 55)
            }
            .padding()
            .alert(isPresented: $alert) {
                Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("Ok")))
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

extension SignUpView {
    func signUpWithEmail(email: String,password : String,completion: @escaping (Bool,String)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if err != nil{
                completion(false,(err?.localizedDescription)!)
                return
            }
            completion(true,(res?.user.email)!)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(show: .constant(true), userEmail: .constant("example@email.com"))
                        .previewDisplayName("Show SignUpView with email")
    }
}

