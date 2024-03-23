struct CoinSearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.theme.secondaryColor : Color.theme.accent)
            
            TextField("Search", text: $searchText)
                .autocorrectionDisabled(true)
                .foregroundColor(Color.theme.accent)
                .overlay(clearButtonOverlay, alignment: .trailing)
        }
        .modifier(SearchBarStyle())
    }
    
    private var clearButtonOverlay: some View {
        Image(systemName: "xmark.circle.fill")
            .padding()
            .offset(x: 10)
            .foregroundColor(Color.theme.accent)
            .opacity(searchText.isEmpty ? 0.0 : 1.0)
            .onTapGesture {
                UIApplication.shared.endEditing()
                searchText = ""
            }
    }
}

struct SearchBarStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(AppColors.background, lineWidth: 1)
                    )
            )
            .padding(.bottom, 10)
    }
}

struct CoinSearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        CoinSearchBarView(searchText: .constant(""))
    }
}
