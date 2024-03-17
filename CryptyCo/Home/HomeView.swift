
import SwiftUI
import FirebaseCore
import FirebaseAuth

struct HomeView : View {
    
    var body : some View{
        
        VStack{
            HStack{
                Button(action: {
                    UserDefaults.standard.set(false, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                    
                }) {
                    
                    Image("arrowLeft")
                }
                Text("Name")
                    .padding(.leading, 7)
                
                Spacer()
                HStack(spacing: 4)  {
                    Image("sort")
                    
                }
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
