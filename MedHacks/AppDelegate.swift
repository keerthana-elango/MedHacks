//
//  AppDelegate.swift
//  MedHacks
//
//  Created by Olivia on 9/23/16.
//  Copyright © 2016 Olivia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

	var activeCornerRadius : CGFloat = 0
	var incativeCornerRadius : CGFloat = 0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		UINavigationBar.appearance().shadowImage = UIImage()
		UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
		
		window!.clipsToBounds = true
		
		let animation : CABasicAnimation = CABasicAnimation(keyPath: "cornerRadius")
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
		animation.fromValue = activeCornerRadius
		animation.toValue = activeCornerRadius
		animation.duration = 0.15
		window!.layer.cornerRadius = activeCornerRadius
		window!.layer.add(animation, forKey: "cornerRadius")
        return true
    }

	func applicationWillResignActive(_ application: UIApplication) {
		let animation : CABasicAnimation = CABasicAnimation(keyPath: "cornerRadius")
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
		animation.fromValue = activeCornerRadius
		animation.toValue = incativeCornerRadius
		animation.duration = 0.15
		window!.layer.cornerRadius = incativeCornerRadius
		window!.layer.add(animation, forKey: "cornerRadius")
	}

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

	func applicationDidBecomeActive(_ application: UIApplication) {
		let animation : CABasicAnimation = CABasicAnimation(keyPath: "cornerRadius")
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
		animation.fromValue = incativeCornerRadius
		animation.toValue = activeCornerRadius
		animation.duration = 0.15
		window!.layer.cornerRadius = activeCornerRadius
		window!.layer.add(animation, forKey: "cornerRadius")
	}

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

