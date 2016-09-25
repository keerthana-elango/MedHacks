//
//  ViewController.swift
//  MedHacks
//
//  Created by Olivia on 9/23/16.
//  Copyright © 2016 Olivia. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
	
    @IBOutlet weak var beginRecordingButton: UIButton!
	override func viewDidLoad() {
		super.viewDidLoad()
        
        beginRecordingButton.layer.cornerRadius = 10
		
		// Data from user input - currently bs
		let myString = "Today I'm feeling sad"
		
		print(myString)

		let parameters: Parameters = [
			"message": "myString",
		]

		Alamofire.request("https://mywebsite.com/post", parameters: parameters).responseJSON { response in
				print(response.request)
				print(response.response)
				print(response.data)
				print(response.result)
		}
	
		// Get Request - 100% works
		Alamofire.request("http://mywebsite.com/get").responseJSON { response in
			print(response.request)  // original URL request
			print(response.response) // HTTP URL response
			print(response.data)     // server data
			print(response.result)   // result of response serialization
			
			if let JSON = response.result.value {
				print("JSON: \(JSON)")
			}
		}
	}
}
