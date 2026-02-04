//
//  PedalPalApp.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 3/2/26.
//

import SwiftUI
import SwiftData

@main
struct PedalPalApp: App {
    private let environment = AppEnvironment()

    var body: some Scene {
        WindowGroup {
            AuthGateView()
                .modelContainer(environment.modelContainer)
        }
    }
}
