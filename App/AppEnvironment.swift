//
//  AppEnvironment.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 3/2/26.
//

import SwiftData

final class AppEnvironment {
    let modelContainer: ModelContainer

    init() {
        let schema = Schema([
            // Add real models later
        ])

        self.modelContainer = try! ModelContainer(
            for: schema
        )
    }
}
