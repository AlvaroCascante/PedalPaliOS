//
//  AppDelegate.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 5/2/26.
//

import UIKit
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // Guard against duplicate Firebase configuration which throws an exception if configured twice.
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        return true
    }

    // Required for Google Sign-In callback
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
