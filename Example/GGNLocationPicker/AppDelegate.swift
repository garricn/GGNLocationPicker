//
//  AppDelegate.swift
//  GGNLocationPicker
//
//  Created by Garric Nahapetian on 09/21/2016.
//  Copyright (c) 2016 Garric Nahapetian. All rights reserved.
//

import UIKit
import MapKit
import GGNLocationPicker

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let locationPicker = LocationPickerVC()

        locationPicker.pickerDelegate = self
        locationPicker.didPickLocation = { annotation in
            print(annotation)
        }

        let navigationController = UINavigationController(rootViewController: locationPicker)
        let frame = UIScreen.mainScreen().bounds
        window = UIWindow(frame: frame)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

extension AppDelegate: LocationPickerDelegate {
    func didPickLocation(with annotation: MKAnnotation) {
        print(annotation)
    }
}
