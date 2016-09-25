//
//  MessageComposer.swift
//  Lippi
//
//  Created by Olivia on 8/10/16.
//  Copyright © 2016 Olivia. All rights reserved.
//

import Foundation
import MessageUI

let textMessageRecipients = ["1-417-501-6709"]

class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
	
	// Checks if a text message can be sent from the user's device
	func canSendText() -> Bool {
		return MFMessageComposeViewController.canSendText()
	}
	// Configures and returns a MFMessageComposeViewController instance
	func configuredMessageComposeViewController() -> MFMessageComposeViewController {
		let messageComposeVC = MFMessageComposeViewController()
		messageComposeVC.messageComposeDelegate = self
		messageComposeVC.recipients = textMessageRecipients
		messageComposeVC.body = "Hi! I'm feeling a lot of anxiety right now, and I would appreciate some advice on how to calm down."
		return messageComposeVC
	}
	// Dismisses the view controller when the user is finished with it
	func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
		controller.dismiss(animated: true, completion: nil)
	}
}
