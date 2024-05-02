//
//  EntrySignupView.swift
//  DesignerGenesSignup
//
//  Created by Jaden Nation on 5/1/24.
//

import SwiftUI

class EntrySignupViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
}

struct EntrySignupView: View {
    @ObservedObject private var viewModel: EntrySignupViewModel = EntrySignupViewModel()
    
    struct FieldModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .autocorrectionDisabled()
                .tint(.black)
            
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(Color.white)
                .cornerRadius(5)
                
                
        }
    }
    
    private func MakeTextField(defaultValue: String, value: Binding<String>, isSecure: Bool = false) -> some View {
        if isSecure {
            return AnyView(SecureField(defaultValue, text: value)
                .modifier(FieldModifier()))
        }
        return AnyView(TextField(defaultValue, text: value)
            .modifier(FieldModifier()))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    Spacer()
                        .frame(height: 100)
                    Image(systemName: "suit.spade.fill")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .font(.system(size: 150))
                    Spacer()
                        .frame(height: 200)
                    HStack {
                        VStack(alignment: .leading, spacing: 16) {
                            MakeTextField(defaultValue: "Email", value: $viewModel.email)
                            MakeTextField(defaultValue: "Username", value: $viewModel.username)
                            MakeTextField(defaultValue: "Password", value: $viewModel.password, isSecure: true)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    HStack {
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Text("Submit")
                                .foregroundStyle(.black)
                        })
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        //                    .background(Color.black)
                        .cornerRadius(5)
                        .padding()
                    }
                }
            }
            
            .background {
                Color(uiColor: .lightGray.withAlphaComponent(0.2))
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    EntrySignupView()
}
