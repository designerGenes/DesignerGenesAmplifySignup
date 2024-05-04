//
//  EntrySignupView.swift
//  DesignerGenesSignup
//
//  Created by Jaden Nation on 5/1/24.
//

import SwiftUI
import Amplify
import Combine

class EntrySignupViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signup () async  {
        let userAttributes = [AuthUserAttribute(.email, value: self.email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        if let result = try? await Amplify.Auth.signUp(username: self.username, password: self.password, options: options) {
            if result.isSignUpComplete {
                postSignup()
            }
        } else {
            print("Unable to sign up, ya dingus")
        }
    }
    
//    @MainActor
    func postSignup() {
        print("Signed up!")
    }
}

struct EntrySignupView: View {
    @State private var keyboardHeight: CGFloat = 0
    @State private var bottomPadding: CGFloat = 0
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
            Form {
                Section {
                    VStack(alignment: .center) {
                        Spacer()
                            .frame(height: 100)
                        Image(systemName: "suit.spade.fill")
                            .renderingMode(.template)
                            .foregroundStyle(Color(uiColor: .gray.withAlphaComponent(0.3)))
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
                                Task { @MainActor in
                                    await self.viewModel.signup()
                                }
                                
                            }, label: {
                                Text("Submit")
                                    .foregroundStyle(.black)
                            })
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .padding()
                        }
                    }
                }
            }
            .background {
                Color(uiColor: .lightGray.withAlphaComponent(0.2))
            }
            .navigationTitle("Sign up")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarHidden(false)
            .navigationBarTitleDisplayMode(.large)
            
                        
        }
        .ignoresSafeArea()
    }
}

#Preview {
    EntrySignupView()
}
