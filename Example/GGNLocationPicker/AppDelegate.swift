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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let coordinate = CLLocationCoordinate2D(latitude: 34.0, longitude: -118.24)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Hello, World!"
        let locationPicker = LocationPickerVC(with: annotation)

        locationPicker.pickerDelegate = self
        locationPicker.didPick = { annotation in
            print(annotation)
        }

        let navigationController = UINavigationController(rootViewController: locationPicker)
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

extension AppDelegate: LocationPickerDelegate {
    func didPick(_ annotation: MKAnnotation) {
        print(annotation)
    }
}
