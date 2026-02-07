//
//  PedalPalApp.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 3/2/26.
//

import FirebaseCore
import GoogleSignIn
import SwiftUI

@main
struct PedalPalApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    private let environment = AppEnvironment()

    init() {
        // Avoid configuring Firebase twice (AppDelegate + SwiftUI App may both run).
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        if let clientID = FirebaseApp.app()?.options.clientID {
                GIDSignIn.sharedInstance.configuration =
                    GIDConfiguration(clientID: clientID)
            }
    }
    
    var body: some Scene {
        WindowGroup {
            AuthGateView(environment: environment)
                .environmentObject(environment)
        }
    }
}
