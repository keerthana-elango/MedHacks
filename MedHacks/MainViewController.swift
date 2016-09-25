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

class VideoViewController: UIViewController, SFSpeechRecognizerDelegate {
	
    @IBOutlet weak var textView: UITextView!
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
			
			let parameters = [
				"message" : "\(finalMessage)"
				
				]
				print(parameters)
			Alamofire.request("http://myfirstelasticbeans123-env1.us-west-2.elasticbeanstalk.com/post", parameters: parameters).responseJSON { response in
				
				print(response.request!)  // original URL request
							print(response.response!) // HTTP URL response
							print(response.data!)     // server data
							print(response.result)   // result of response serialization
				
//				print(response.result.value)
				//
								let JSON = response.result.value
									print("JSON: \(JSON)")
			
			}}
		else {
            
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
                            
                            self.textView.text = result.bestTranscription.formattedString
                            
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
