//
//  ViewController.swift
//  MedHacks
//
//  Created by Olivia on 9/23/16.
//  Copyright © 2016 Olivia. All rights reserved.
//

import UIKit
import Alamofire
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		beginRecordingButton.layer.cornerRadius = 10
		
		speechRecognizer.delegate = self
		
		beginRecordingButton.isEnabled = false
		
		SFSpeechRecognizer.requestAuthorization { (authStatus) in
			
			OperationQueue.main.addOperation({
				
				switch authStatus {
				case .authorized:
					self.beginRecordingButton.isEnabled = true
					
				case .denied:
					self.beginRecordingButton.isEnabled = false
					self.beginRecordingButton.setTitle("User denied access to speech recognition", for: .disabled)
					
				case .restricted:
					self.beginRecordingButton.isEnabled = false
					self.beginRecordingButton.setTitle("Speech recognition is restricted on this device", for: .disabled)
					
				case .notDetermined:
					self.beginRecordingButton.isEnabled = false
					self.beginRecordingButton.setTitle("Speech recognition has not yet been authorised", for: .disabled)
					
				}
			})
		}
		
//		Alamofire.request("https://myfirstelasticbeans123-env1.us-west-2.elasticbeanstalk.com/data", parameters: parameters).responseJSON { response in
//			print(response.request)
//			print(response.response)
//			print(response.data)
//			print(response.result)
//		}
		//
//		Alamofire.request("http://myfirstelasticbeans123-env1.us-west-2.elasticbeanstalk.com/data").responseJSON { response in
//			print(response.request!)  // original URL request
//			print(response.response!) // HTTP URL response
//			print(response.data!)     // server data
//			print(response.result)   // result of response serialization
//			
//			if let JSON = response.result.value {
//				print("JSON: \(JSON)")
//			}
//}
}
	
    @IBOutlet weak var beginRecordingButton: UIButton!
    
    // Class variables
    let speechRecognizer = SFSpeechRecognizer()!
    let audioEngine = AVAudioEngine()
    var recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask = SFSpeechRecognitionTask()
    
    var finalMessage = ""
    
    // Process of recording and saving text to a variable - howImFeeling
    @IBAction func recordingButtonTapped(_ sender: AnyObject) {
        
        if audioEngine.isRunning {
            
            audioEngine.stop()
            recognitionRequest.endAudio()
            recognitionTask.cancel()
            beginRecordingButton.setTitle("Start Recording", for: [])
            recognitionRequest.endAudio()
			print(finalMessage)
			
			
//			let parameters: Parameters = [
//				"message": "\(finalMessage)",
//				]
//			
//			Alamofire.request("http://myfirstelasticbeans123-env1.us-west-2.elasticbeanstalk.com/post", parameters: parameters).responseJSON { response in
//				
//				let JSON = response.result.value
//					print("JSON: \(JSON)")
//			et message = "I am ashish"{
			let parameters = [
				"message" : "Hello how are you"
				
				]
				print(parameters)
				Alamofire.request("http://myfirstelasticbeans123-env1.us-west-2.elasticbeanstalk.com/post",parameters:parameters,encoding: .JSON).respondJSON{ response in
					print(response)
				}

			
        } else {
            
            beginRecordingButton.setTitle("Stop Recording", for: [])
			
			print(finalMessage)
            
            do {
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(AVAudioSessionCategoryRecord)
                try audioSession.setMode(AVAudioSessionModeMeasurement)
                try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
                
                if let inputNode = audioEngine.inputNode {
                    
                    recognitionRequest.shouldReportPartialResults = true
                    
                    recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
                        
                        if let result = result {
                            
                            self.finalMessage = result.bestTranscription.formattedString
							print(self.finalMessage)
							
                            if result.isFinal {
                                
                                self.audioEngine.stop()
                                inputNode.removeTap(onBus: 0)
                            }
                        }
                    })
                    
                    let recordingFormat = inputNode.outputFormat(forBus: 0)
                    
                    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat, block: { (buffer, when) in
                        
                        self.recognitionRequest.append(buffer)
                        
                    })
                    audioEngine.prepare()
                    try audioEngine.start()
                }
            } catch {
                
                // Handle errors
            }
        }
    }
}
