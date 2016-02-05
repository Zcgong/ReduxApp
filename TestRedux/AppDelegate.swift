//
//  AppDelegate.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 29/01/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        api = GoApi()
        store = DefaultStore(aState: MyState(), aReducer: MainReducer())
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = Navigation().controller
        window?.makeKeyAndVisible()
        return true
    }
}