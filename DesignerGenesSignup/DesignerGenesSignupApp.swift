//
//  DesignerGenesSignupApp.swift
//  DesignerGenesSignup
//
//  Created by Jaden Nation on 5/1/24.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin


@main
struct DesignerGenesSignupApp: App {
    init() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
        } catch {
            fatalError("Could not configure Amplify")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            EntrySignupView()
        }
        
    }
}
