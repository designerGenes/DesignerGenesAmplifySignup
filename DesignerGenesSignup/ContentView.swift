//
//  ContentView.swift
//  DesignerGenesSignup
//
//  Created by Jaden Nation on 5/1/24.
//

import SwiftUI

class SignupScreenViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
}

struct ContentView: View {
    @ObservedObject private var viewModel: SignupScreenViewModel = SignupScreenViewModel()
    
    private func MakeTextField(defaultValue: String, value: Binding<String>) -> some View {
        TextField(defaultValue, text: value)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Color.white)
            .cornerRadius(5)
        
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    Spacer()
                        .frame(height: 100)
                    Image(systemName: "drop.fill")
                        .renderingMode(.template)
                        .foregroundColor(.blue)
                        .font(.system(size: 200))
                    HStack {
                        VStack(alignment: .leading) {
                            MakeTextField(defaultValue: "Email", value: $viewModel.email)
                            MakeTextField(defaultValue: "Username", value: $viewModel.username)
                            MakeTextField(defaultValue: "Password", value: $viewModel.password)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Submit")
                    })
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(5)
                    .padding()
                }
            }
            
            .background {
                Color(uiColor: .lightGray)
            }
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    ContentView()
}
