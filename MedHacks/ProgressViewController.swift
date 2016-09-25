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
		
//		@IBOutlet weak var lineChartView: LineChartView!
//		@IBOutlet weak var pieChartView: PieChartView!
//		
//		override func viewDidLoad() {
//			super.viewDidLoad()
//			
//			let emotions = ["Anger", "Disgust", "Fear", "Joy", "Sadness"]
//			let percentage = [36.0, 19.0, 6.0, 13.0, 26.0]
//			
//			setChart(dataPoints: emotions, values: percentage)
//		}
//		
//		func setChart(dataPoints: [String], values: [Double]) {
//			
//			var dataEntries: [ChartDataEntry] = []
//			
//			for i in 0..<dataPoints.count {
//				let dataEntry = ChartDataEntry(x: Double(i),y: values[i])
//				dataEntries.append(dataEntry)
//			}
//			
//			let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Emotion")
//			
//			var dataSets = [IChartDataSet]()
//			
//			dataSets.append(pieChartDataSet)
//			
//			let pieChartData = PieChartData(dataSets: dataSets)
//			pieChartView.data = pieChartData
//			
//			var colors: [UIColor] = []
//			
//			for i in 0..<dataPoints.count {
//				let red = Double(arc4random_uniform(256))
//				let green = Double(arc4random_uniform(256))
//				let blue = Double(arc4random_uniform(256))
//				
//				let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
//				colors.append(color)
//			}
//			
//			pieChartDataSet.colors = colors
//			
//			
//			let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Percentage")
//			
//			var datasets1 = [IChartDataSet]()
//			
//			datasets1.append(lineChartDataSet)
//			
//			let lineChartData = LineChartData(dataSets: datasets1)
//			lineChartView.data = lineChartData
//			
//		}
//	}
}
