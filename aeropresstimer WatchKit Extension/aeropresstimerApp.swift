//
//  aeropresstimerApp.swift
//  aeropresstimer WatchKit Extension
//
//  Created by Daniel Pape on 31/07/2021.
//

import SwiftUI

@main
struct aeropresstimerApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
