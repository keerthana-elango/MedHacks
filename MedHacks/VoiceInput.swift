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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Data from user input - currently bs
		let myString = "Today I'm feeling sad"
		
		print(myString)
		
		// Post request - new for Swift 3.0 & Alamofire 4.0, needs to be tested
//		Alamofire.request("http://mywebsite.com/post", method: .post, parameters: [:], encoding: "myString", headers: [:])
		
		let parameters: Parameters = [
			"test": "myString",
		]
		
		// All three of these calls are equivalent
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
//extension String: ParameterEncoding {
//	
//	public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
//		var request = try urlRequest.asURLRequest()
//		request.httpBody = data(using: .utf8, allowLossyConversion: false)
//		return request
//	}
//}



