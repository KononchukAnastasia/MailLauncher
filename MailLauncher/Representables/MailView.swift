//
//  MailView.swift
//  MailLauncher
//
//  Created by Анастасия Конончук on 24.06.2024.
//

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
    // MARK: - Public Property
    
    let mailData: MailData
    let completion: (Result<MFMailComposeResult, Error>) -> Void
    
    static var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }
    
    // MARK: - Public Methods
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.mailComposeDelegate = context.coordinator
        viewController.setToRecipients([mailData.recipientEmail])
        viewController.setSubject(mailData.subject)
        viewController.setMessageBody(mailData.body, isHTML: false)
        return viewController
    }

    func updateUIViewController(
        _ uiViewController: MFMailComposeViewController,
        context: Context
    ) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(completion: completion)
    }
}

// MARK: - Extension MailView

extension MailView {
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        private let completion: (Result<MFMailComposeResult, Error>) -> Void
        
        init(
            completion: @escaping (Result<MFMailComposeResult, Error>) -> Void
        ) {
            self.completion = completion
        }
        
        func mailComposeController(
            _ controller: MFMailComposeViewController,
            didFinishWith result: MFMailComposeResult,
            error: Error?
        ) {
            defer { controller.dismiss(animated: true) }
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(result))
            }
        }
    }
}
