//
//  ContentView.swift
//  MailLauncher
//
//  Created by Анастасия Конончук on 24.06.2024.
//

import SwiftUI

struct AlertData: Identifiable {
    // MARK: - Public Property
    
    let id = UUID()
    let message: String
}

struct EmailComposeView: View {
    // MARK: - Property Wrappers
    
    @State private var alertData: AlertData?
    @State private var mailData: MailData?
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Button("Send Email") {
                if MailView.canSendMail {
                    mailData = DataManager.mailData
                }
            }
        }
        .sheet(item: $mailData) { mailData in
            MailView(mailData: mailData) { result in
                switch result {
                case .success(let mailResult):
                    switch mailResult {
                    case .cancelled:
                        alertData = AlertData(message: "Cancelled")
                    case .saved:
                        alertData = AlertData(message: "Mail saved as draft")
                    case .sent:
                        alertData = AlertData(message: "Mail sent successfully")
                    case .failed:
                        alertData = AlertData(message: "Mail sending failed")
                    default:
                        alertData = AlertData(message: "Unknown result")
                    }
                case .failure(let error):
                    alertData = AlertData(message: error.localizedDescription)
                }
            }
            .ignoresSafeArea()
        }
        .alert(item: $alertData) { alertData in
            Alert(
                title: Text("Mail Result"),
                message: Text(alertData.message)
            )
        }
    }
}

// MARK: - Preview

#Preview {
    EmailComposeView()
}
