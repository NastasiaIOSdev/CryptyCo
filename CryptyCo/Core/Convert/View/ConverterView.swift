
import SwiftUI

struct ConverterView: View {
    @State private var selectedCoin: String = "Bitcoin"
    @State private var enteredNumber: String = ""

    var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {
                
                LinearGradient(
                    colors: [Color(red: 0.99, green: 0.87, blue: 0.18, opacity: 0.3), Color(red: 0.99, green: 0.87, blue: 0.18, opacity: 0.3)] , startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack(alignment: .center) {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    HStack {
                        Text("Converter ")
                            .font(AppFonts.medium28.font)
                            .padding([.leading, .trailing])
                        Spacer()
                    }
                    
                    VStack(alignment: .leading){
                        HStack(spacing: 10) {
                            Text("Select crypto")
                                .padding([.leading, .trailing])
                            
                            Picker("", selection: $selectedCoin) {
                               
                            }
                            .pickerStyle(WheelPickerStyle())
                            Text(enteredNumber.isEmpty ? "0" : enteredNumber)
                                .padding(15)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(15)
                        HStack {
                            Text("to RUB")
                                .padding([.leading, .trailing])
                            Spacer()
                            Text("0")
                        }
                        .padding(15)
                    }
                    .font(AppFonts.medium18.font)
                    .padding([.top,.bottom], 30)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding([.leading, .trailing], 25)
                    
                    Spacer()
                    VStack(alignment: .center) {
                        HStack{
                            Spacer()
                            VStack {
                                HStack {
                                    Button(action: {
                                        enteredNumber += "1"
                                    }) {
                                        Text("1")
                                    }
                                    .frame(width: 40, height: 40)
                                    .padding(20)
                                    Button(action: {
                                        enteredNumber += "2"
                                    }) {
                                        Text("2")
                                    }.frame(width: 40, height: 40)
                                        .padding(20)
                                    
                                    Button(action: {
                                        enteredNumber += "3"
                                    }) {
                                        Text("3")
                                    }.frame(width: 40, height: 40)
                                        .padding(20)
                                }
                                HStack {
                                    Button(action: {
                                        enteredNumber += "4"
                                    }) {
                                        Text("4")
                                    }.frame(width: 40, height: 40)
                                        .padding(20)
                                    Button(action: {
                                        enteredNumber += "5"
                                    }) {
                                        Text("5")
                                    }.frame(width: 40, height: 40)
                                        .padding(20)
                                    
                                    Button(action: {
                                        enteredNumber += "6"
                                    }) {
                                        Text("6")
                                    }.frame(width: 40, height: 40)
                                        .padding(20)
                                }
                                HStack {
                                    Button(action: {
                                        enteredNumber += "7"
                                    }) {
                                        Text("7")
                                    }.frame(width: 40, height: 40)
                                        .padding(20)
                                    Button(action: {
                                        enteredNumber += "8"
                                    }) {
                                        Text("8")
                                    }.frame(width: 40, height: 40)
                                        .padding(20)
                                    
                                    Button(action: {
                                        enteredNumber += "9"
                                    }) {
                                        Text("9")
                                    }.frame(width: 40, height: 40)
                                        .padding(20)
                                }
                                HStack {
                                    Button(action: {
                                        enteredNumber += "."
                                    }) {
                                        Text(".")
                                    }.frame(width: 40, height: 40)
                                        .padding(20)
                                    HStack {
                                        Button(action: {
                                            enteredNumber += "0"
                                        }) {
                                            Text("0")
                                        }.frame(width: 40, height: 40)
                                            .padding(20)
                                    }
                                    
                                    Button(action: {
                                        if !enteredNumber.isEmpty {
                                            enteredNumber.removeLast()
                                        }
                                    }) {
                                        Image("cancel")
                                    }.frame(width: 40, height: 40)
                                        .padding(20)
                                        .foregroundColor(AppColors.black)
                
                                }
                                .padding(.bottom, 50)
                            }
                            Spacer()
                        }
                    }
                    .padding([.leading, .trailing], 25)
                    .padding(.top, 60)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25).offset(x: 0, y: 35))
                    .font(AppFonts.medium28.font)
                }
            }
        }
    }
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView()
    }
}
