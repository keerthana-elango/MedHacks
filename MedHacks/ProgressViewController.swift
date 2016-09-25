//
//  ProgressViewController.swift
//  MedHacks
//
//  Created by Olivia on 9/24/16.
//  Copyright © 2016 Olivia. All rights reserved.
//

import UIKit
//import Charts

class ProgressViewController: UIViewController {
	
	@IBOutlet weak var lineChartView: LineChartView!
	@IBOutlet weak var pieChartView: PieChartView!
 
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		
		let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
		let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
		
		setChart(dataPoints: months, values: unitsSold)
		
	}
	
	func setChart(dataPoints: [String], values: [Double]) {
		
		var dataEntries: [ChartDataEntry] = []
		
		for i in 0..<dataPoints.count {
			let dataentry = ChartDataEntry(x: Double(i),y: values[i])
			dataEntries.append(dataentry)
		}
		
		let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Percetage")
		
		var datasets = [IChartDataSet]()
		
		datasets.append(pieChartDataSet)
		
		let pieChartData = PieChartData(dataSets: datasets)
		pieChartView.data = pieChartData
		
		var colors: [UIColor] = []
		
		for i in 0..<dataPoints.count {
			let red = Double(arc4random_uniform(256))
			let green = Double(arc4random_uniform(256))
			let blue = Double(arc4random_uniform(256))
			
			let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
			colors.append(color)
		}
		
		pieChartDataSet.colors = colors
		
		
		let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Percentage")
		
		var datasets1 = [IChartDataSet]()
		
		datasets1.append(lineChartDataSet)
		
		let lineChartData = LineChartData(dataSets: datasets1)
		lineChartView.data = lineChartData
		
	}
 
}
