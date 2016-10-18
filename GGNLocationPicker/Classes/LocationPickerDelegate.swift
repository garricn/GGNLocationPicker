//
//  LocationPickerDelegate.swift
//  Pods
//
//  Created by Garric Nahapetian on 8/21/16.
//
//

import MapKit

public protocol LocationPickerDelegate: class {
    func didPick(annotation: MKAnnotation)
}
