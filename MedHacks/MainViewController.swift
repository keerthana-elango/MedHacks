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
	}
	
		// Post request - new for Swift 3.0 & Alamofire 4.0, needs to be tested

//		let parameters: Parameters = [
//			"test": "myString",
//		]
//
//		Alamofire.request("https://mywebsite.com/post", parameters: parameters).responseJSON { response in
//				print(response.request)
//				print(response.response)
//				print(response.data)
//				print(response.result)
//		}
//	
//		// Get Request - 100% works
//		Alamofire.request("http://mywebsite.com/get").responseJSON { response in
//			print(response.request)  // original URL request
//			print(response.response) // HTTP URL response
//			print(response.data)     // server data
//			print(response.result)   // result of response serialization
//			
//			if let JSON = response.result.value {
//				print("JSON: \(JSON)")
//			}
//		}

	let todosEndpoint: String = "http://localhost:3000/signup"
	
	@IBAction func sendData(_ sender: AnyObject) {
//		let message1 = message.text {
//			let parameters = [
//				"message": message
//				
//			]
//			print(parameters)
////			            Alamofire.request(.POST,  todosEndpoint, parameters:parameters, encoding: .JSON).responseJSON {
////			                response in
////			                print(response)
////			
//			
//			
//			Alamofire.request("http://localhost:7000/ashish", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
//				
//				print(response)
//			}
//			
		
		
		let parameters: Parameters = [
					"message": "I ma doing good",
				]
		print(parameters);
		
		Alamofire.request(.POST,  todosEndpoint, parameters:parameters, encoding: .JSON).responseJSON {
						                response in
						                print(response)
			
		}
		
			
		
	}
	}
