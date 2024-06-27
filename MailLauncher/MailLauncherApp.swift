//
//  MailLauncherApp.swift
//  MailLauncher
//
//  Created by Анастасия Конончук on 24.06.2024.
//

import SwiftUI

@main
struct MailLauncherApp: App {
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            EmailComposeView()
        }
    }
}
