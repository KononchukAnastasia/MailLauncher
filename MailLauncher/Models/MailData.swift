//
//  MailData.swift
//  MailLauncher
//
//  Created by Анастасия Конончук on 25.06.2024.
//

import Foundation

struct MailData: Identifiable {
    // MARK: - Public Property
    
    let id = UUID()
    let recipientEmail: String
    let subject: String
    let body: String
}
