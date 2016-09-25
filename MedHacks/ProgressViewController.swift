//
//  ProgressViewController.swift
//  MedHacks
//
//  Created by Olivia on 9/24/16.
//  Copyright © 2016 Olivia. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
	
	let messageComposer = MessageComposer()
	
	@IBAction func sendTextMessageButtonTapped(_ sender: AnyObject) {
		if (messageComposer.canSendText()) {
			
			// Obtain a configured MFMessageComposeViewController
			let messageComposeVC = messageComposer.configuredMessageComposeViewController()
			present(messageComposeVC, animated: true, completion: nil)
		} else {
			let errorAlert = UIAlertController(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", preferredStyle: .alert)
			errorAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
			self.present(errorAlert, animated: true){}
		}

	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
 
}
